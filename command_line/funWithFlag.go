package main

import (
	"flag"
	"fmt"
	"strings"
)

type NamesFlag struct {
	Names []string
}

func (s *NamesFlag) GetNames() []string {
	return s.Names
}

func (s *NamesFlag) String() string {
	return fmt.Sprint(s.Names)
}

func (s *NamesFlag) Set(v string) error {
	if len(s.Names) > 0 {
		return fmt.Errorf("Нельзя использовать флаг больше одного раза")
	}
	names := strings.Split(v, ",")
	for _, item := range names {
		s.Names = append(s.Names, item)
	}
	return nil
}
func main() {
	var myNames NamesFlag
	minusK := flag.Int("k", 0, "An int")
	minusO := flag.String("o", "Mihalis", "The name")
	flag.Var(&myNames, "names", "Comma-separated list")
	flag.Parse()
	fmt.Println("-k:", *minusK)
	fmt.Println("-o:", *minusO)
	for i, item := range myNames.GetNames() {
		fmt.Println(i, item)
	}
	fmt.Println("Remaining command line arguments:")
	for index, val := range flag.Args() {
		fmt.Println(index, ":", val)
	}
}
