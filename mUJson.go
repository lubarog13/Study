package main

import (
	"encoding/json"
	"fmt"
)

type Record struct {
	Name    string
	Surname string
	Tel     []Telephone
}

type Telephone struct {
	Mobile bool
	Number string
}

func main() {
	myrecord := Record{
		Name:    "Masha",
		Surname: "Ivanova",
		Tel:     []Telephone{Telephone{Mobile: true, Number: "123456789"}, Telephone{Mobile: false, Number: "12234"}},
	}
	rec, err := json.Marshal(&myrecord)
	if err != nil {
		fmt.Println(err)
		return
	}
	fmt.Println(string(rec))
	var unRec Record
	err1 := json.Unmarshal(rec, &unRec)
	if err1 != nil {
		fmt.Println(err1)
		return
	}

	fmt.Println(unRec)
}
