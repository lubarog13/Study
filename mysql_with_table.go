package main

import (
	"database/sql"
	"fmt"

	"fyne.io/fyne"
	"fyne.io/fyne/app"
	"fyne.io/fyne/layout"
	"fyne.io/fyne/widget"
	_ "github.com/go-sql-driver/mysql"
)

type Material struct {
	id           int
	title        string
	countInPack  int
	unit         string
	countInStock sql.NullFloat64
	minCount     float64
	description  sql.NullString
	cost         float32
	image        sql.NullString
	materialType string
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
		err := rows.Scan(&m.id, &m.title, &m.countInPack, &m.unit, &m.countInStock, &m.minCount, &m.description, &m.cost, &m.image, &m.materialType)
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
		fmt.Println(m.id, m.title, m.countInPack, m.unit, m.countInStock.Float64, m.minCount, m.description.String, m.cost, m.image.String, m.materialType)
		labels = append(labels, widget.NewLabel(fmt.Sprintln(m.id, m.title, m.countInPack, m.unit, m.countInStock.Float64, m.minCount, m.description.String, m.cost, m.image.String, m.materialType)))
	}
	l := widget.NewTable(
		func() (int, int) {
			return len(materials), 10
		},
		func() fyne.CanvasObject {
			item := widget.NewLabel("Template")
			item.Resize(fyne.Size{
				Width:  400,
				Height: 20,
			})
			return item
		},
		func(cell widget.TableCellID, item fyne.CanvasObject) {
			switch cell.Col {
			case 0:
				item.(*widget.Label).SetText(fmt.Sprintf("%d", materials[cell.Row].id))
				break
			case 1:
				item.(*widget.Label).SetText(fmt.Sprintf("%s", materials[cell.Row].title))
				break
			case 2:
				item.(*widget.Label).SetText(fmt.Sprintf("%d", materials[cell.Row].countInPack))
				break
			case 3:
				item.(*widget.Label).SetText(fmt.Sprintf("%s", materials[cell.Row].unit))
				break
			case 4:
				item.(*widget.Label).SetText(fmt.Sprintf("%.2f", materials[cell.Row].countInStock.Float64))
				break
			case 5:
				item.(*widget.Label).SetText(fmt.Sprintf("%.2f", materials[cell.Row].minCount))
				break
			case 6:
				item.(*widget.Label).SetText(fmt.Sprintf("%s", materials[cell.Row].description.String))
				break
			case 7:
				item.(*widget.Label).SetText(fmt.Sprintf("%.2f", materials[cell.Row].cost))
				break
			case 8:
				item.(*widget.Label).SetText(fmt.Sprintf("%s", materials[cell.Row].image.String))
				break
			case 9:
				item.(*widget.Label).SetText(fmt.Sprintf("%s", materials[cell.Row].materialType))
				break
			}
			item.(*widget.Label).Resize(fyne.Size{
				Width:  400,
				Height: 20,
			})
		})
	l.SetColumnWidth(1, 300)
	vBox.Append(widget.NewButton("Закрыть", func() {
		app.Quit()
	}))
	layout := layout.NewFixedGridLayout(fyne.NewSize(1200, 800))
	container := fyne.NewContainerWithLayout(layout, l)
	scrollContainer := widget.NewScrollContainer(container)
	vBox.Append(scrollContainer)
	w.SetContent(scrollContainer) //устанавливаем контент для окна приложения
	w.Resize(fyne.NewSize(1200, 600))

	w.ShowAndRun()
}
