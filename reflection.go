package main

import (
	"fmt"
	"os"
	"reflect"
)

type a struct {
	X int
	Y float64
	Z string
}

type b struct {
	F int
	G int
	H float64
	I string
}

func main() {
	x := 100
	xRef := reflect.ValueOf(&x).Elem()
	xType := xRef.Type()
	fmt.Printf("The type of x is %s\n", xType)
	A := a{100, 100.12, "Struct a"}
	B := b{120, 140, 10.5, "Struct b"}
	var r reflect.Value
	arguments := os.Args
	if len(arguments) == 1 {
		r = reflect.ValueOf(&A).Elem()
	} else {
		r = reflect.ValueOf(&B).Elem()
	}
	iType := r.Type()
	fmt.Printf("i Type: %s\n", iType)
	fmt.Printf("The %d fields of %s are:\n", r.NumField(), iType)
	for i := 0; i < r.NumField(); i++ {
		fmt.Printf("Field name: %s ", iType.Field(i).Name)
		fmt.Printf("with type: %s ", r.Field(i).Type())
		fmt.Printf("and value: %v\n", r.Field(i).Interface())
	}
}
