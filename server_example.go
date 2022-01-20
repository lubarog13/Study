package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
	_ "github.com/go-sql-driver/mysql"
	"gopkg.in/guregu/null.v3"
)

type Material struct {
	Id           int         `json:"id"`
	Title        string      `json:"title"`
	CountInPack  int         `json:"countInPack"`
	Unit         string      `json:"unit"`
	CountInStock null.Float  `json:"countInStock,omitempty"`
	MinCount     float64     `json:"minCount"`
	Description  null.String `json:"description,omitempty"`
	Cost         float32     `json:"cost"`
	Image        null.String `json:"image,omitempty"`
	MaterialType string      `json:"materialType"`
}

type album struct {
	ID     string  `json:"id"`
	Title  string  `json:"title"`
	Artist string  `json:"artist"`
	Price  float64 `json:"price"`
}

var albums = []album{
	{ID: "1", Title: "Blue Train", Artist: "John Coltrane", Price: 56.99},
	{ID: "2", Title: "Jeru", Artist: "Gerry Mulligan", Price: 17.99},
	{ID: "3", Title: "Sarah Vaughan anРезинкаd Clifford Brown", Artist: "Sarah Vaughan", Price: 39.99},
}

func getConnection() *sql.DB {
	db, err := sql.Open("mysql", "root:helloSomebody@/shop")
	if err != nil {
		panic(err)
	}
	return db
}

func getAlbums(c *gin.Context) {
	c.IndentedJSON(http.StatusOK, albums)
}

func postAlbums(c *gin.Context) {
	var newAlbum album

	// Call BindJSON to bind the received JSON to
	// newAlbum.
	if err := c.BindJSON(&newAlbum); err != nil {
		return
	}

	// Add the new album to the slice.
	albums = append(albums, newAlbum)
	c.IndentedJSON(http.StatusCreated, newAlbum)
}

func insertMaterial(m *Material) {
	db := getConnection()
	defer db.Close()
	r, err := db.Exec("INSERT INTO Material(Title, CountInPack, Unit, CountInStock, MinCount, Description, Cost, Image, MaterialType) VALUES (?,?,?,?,?,?,?,?,?)", m.Title, m.CountInPack, m.Unit, m.CountInStock.Float64, m.MinCount, m.Description.String, m.Cost, m.Image.String, m.MaterialType)
	if err != nil {
		panic(err)
	}
	id, _ := r.LastInsertId()
	m.Id = int(id)

}

func postMaterials(c *gin.Context) {
	var material Material

	if err := c.BindJSON(&material); err != nil {
		fmt.Println(err)
		return
	}
	insertMaterial(&material)
	c.IndentedJSON(http.StatusCreated, material)
}

func getMaterialsData() []Material {
	db := getConnection()
	defer db.Close()
	rows, err := db.Query("select * from shop.Material")
	if err != nil {
		panic(err)
	}
	defer rows.Close()
	materials := []Material{}
	for rows.Next() {
		m := Material{}
		err := rows.Scan(&m.Id, &m.Title, &m.CountInPack, &m.Unit, &m.CountInStock, &m.MinCount, &m.Description, &m.Cost, &m.Image, &m.MaterialType)
		if err != nil {
			fmt.Println(err)
			continue
		}
		materials = append(materials, m)
	}
	return materials
}

func getMaterials(c *gin.Context) {
	materials := getMaterialsData()
	for _, m := range materials {
		fmt.Println(m.Id, m.Title, m.CountInPack, m.Unit, m.CountInStock.Float64, m.MinCount, m.Description.String, m.Cost, m.Image.String, m.MaterialType)
	}
	rec, _ := json.Marshal(&materials)
	fmt.Println(string(rec))
	c.IndentedJSON(http.StatusOK, materials)
}

func getMaterial(id int) Material {
	db := getConnection()
	defer db.Close()
	rows, err := db.Query("select * from shop.Material where ID=?", id)
	if err != nil {
		panic(err)
	}
	defer rows.Close()
	m := Material{}
	if rows.Next() {
		err := rows.Scan(&m.Id, &m.Title, &m.CountInPack, &m.Unit, &m.CountInStock, &m.MinCount, &m.Description, &m.Cost, &m.Image, &m.MaterialType)
		if err != nil {
			fmt.Println(err)
		}

	}
	return m
}

func updateMaterial(id int, m *Material) error {
	db := getConnection()
	defer db.Close()
	_, err := db.Exec("Update Material set Title=?, CountInPack=?, Unit=?, CountInStock=?, MinCount=?, Description=?, Cost=?, Image=?, MaterialType=? where ID=?", m.Title, m.CountInPack, m.Unit, m.CountInStock.Float64, m.MinCount, m.Description.String, m.Cost, m.Image.String, m.MaterialType, id)
	if err != nil {
		return err
	}
	m.Id = id
	return nil
}

func getMaterialById(c *gin.Context) {
	id, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		return
	}
	material := getMaterial(id)
	if material != (Material{}) {
		c.IndentedJSON(http.StatusOK, getMaterial(id))
		return
	}
	c.IndentedJSON(http.StatusNotFound, gin.H{"message": "material not found"})
}

func updateMaterialById(c *gin.Context) {
	id, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		return
	}
	var material Material

	if err := c.BindJSON(&material); err != nil {
		fmt.Println(err)
		return
	}
	err = updateMaterial(id, &material)
	if err != nil {
		return
	}
	c.IndentedJSON(http.StatusCreated, material)
}

func deleteMaterial(c *gin.Context) {
	id, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		fmt.Print(err)
		return
	}
	db := getConnection()
	defer db.Close()
	_, err = db.Exec("delete from shop.Material where ID=?", id)
	if err != nil {
		fmt.Print(err)
		return
	}
	c.IndentedJSON(http.StatusNoContent, http.NoBody)
}

func main() {

	router := gin.Default()
	router.GET("/materials", getMaterials)

	router.GET("/albums", getAlbums)
	router.POST("/albums", postAlbums)
	router.POST("/materials", postMaterials)
	router.GET("/materials/:id", getMaterialById)
	router.PUT("/materials/:id/update", updateMaterialById)
	router.DELETE("/materials/:id/delete", deleteMaterial)

	router.Run("localhost:8080")

}
