package main

import (
	"fmt"

	"fyne.io/fyne"
	"fyne.io/fyne/app"
	"fyne.io/fyne/dialog"
	"fyne.io/fyne/widget"
)

func main() {
	a := app.New()
	w := a.NewWindow("Table Dialog")
	data := [][]string{
		{"a", "b", "c", "d", "e", "f"},
		{"g", "h", "i", "j", "k", "l"},
		{"m", "n", "o", "p", "q", "r"},
		{"s", "t", "u", "v", "w", "x"},
	}
	w.SetContent(widget.NewButton("Show Table Dialog", func() {
		l := widget.NewTable(
			func() (int, int) {
				return len(data), len(data[0])
			},
			func() fyne.CanvasObject {
				item := widget.NewLabel("Template")
				item.Resize(fyne.Size{
					Width:  200,
					Height: 20,
				})
				return item
			},
			func(cell widget.TableCellID, item fyne.CanvasObject) {
				item.(*widget.Label).SetText(fmt.Sprintf("Cell %s ABC", data[cell.Row][cell.Col]))
				item.(*widget.Label).Resize(fyne.Size{
					Width:  200,
					Height: 20,
				})
			})
		d := dialog.NewCustom("Table Dialog", "OK", l, w)
		d.Show()
		d.Resize(fyne.NewSize(700, 500))
	}))
	w.Resize(fyne.NewSize(700, 600))
	w.ShowAndRun()
}
