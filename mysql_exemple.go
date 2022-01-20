package main

import (
	"database/sql"
	"fmt"

	"fyne.io/fyne"
	"fyne.io/fyne/app"
	"fyne.io/fyne/layout"
	"fyne.io/fyne/widget"
	_ "github.com/go-sql-driver/mysql"
	"gopkg.in/guregu/null.v3"
)

type Material struct {
	Id           int         `json:"id"`
	Title        string      `json:"title"`
	CountInPack  int         `json:"countInPack"`
	Unit         string      `json:"unit"`
	CountInStock null.Float  `json:"-"`
	MinCount     float64     `json:"minCount"`
	Description  null.String `json:"-"`
	Cost         float32     `json:"cost"`
	Image        null.String `json:"-"`
	MaterialType string      `json:"materialType"`
}

type res struct {
	Price float64 `json:"price"`
}

func main() {
	db, err := sql.Open("mysql", "root:helloSomebody@/shop")
	if err != nil {
		panic(err)
	}
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
	app := app.New()

	w := app.NewWindow("Программа для просмотра материалов")

	var vBox = widget.NewVBox()

	labels := []fyne.CanvasObject{}
	for _, m := range materials {
		fmt.Println(m.Id, m.Title, m.CountInPack, m.Unit, m.CountInStock.Float64, m.MinCount, m.Description.String, m.Cost, m.Image.String, m.MaterialType)
		labels = append(labels, widget.NewLabel(fmt.Sprintln(m.Id, m.Title, m.CountInPack, m.Unit, m.CountInStock.Float64, m.MinCount, m.Description.String, m.Cost, m.Image.String, m.MaterialType)))
	}
	vBox.Append(widget.NewButton("Закрыть", func() {
		app.Quit()
	}))
	layout := layout.NewFixedGridLayout(fyne.NewSize(800, 30))
	container := fyne.NewContainerWithLayout(layout, labels...)
	scrollContainer := widget.NewScrollContainer(container)
	vBox.Append(scrollContainer)
	w.SetContent(scrollContainer) //устанавливаем контент для окна приложения
	w.Resize(fyne.NewSize(800, 600))

	w.ShowAndRun()
}
