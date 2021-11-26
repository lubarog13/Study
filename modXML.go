package main

import (
	"encoding/xml"
	"fmt"
	"os"
)

func main() {
	type Address struct {
		City, Country string
	}
	type Employee struct {
		XMLName   xml.Name `xml:"employee"`
		Id        int      `xml:"id,attr"`
		FirstName string   `xml:"name>first"`
		LastName  string   `xml:"name>last"`
		Initials  string   `xml:"name>initials"`
		Height    float32  `xml:"height,omitempty"`
		Address
		Comment string `xml:",comment"`
	}
	r := Employee{Id: 7, FirstName: "Masha", LastName: "Ivanova", Initials: "MIV"}
	r.Comment = "Go programmer"
	r.Height = 175.5
	r.Address = Address{City: "SPB", Country: "Russia"}
	output, err := xml.MarshalIndent(r, "  ", "    ")
	if err != nil {
		fmt.Println("Error", err)
		return
	}
	output = []byte(xml.Header + string(output))
	os.Stdout.Write(output)
	os.Stdout.Write([]byte("\n"))
}
