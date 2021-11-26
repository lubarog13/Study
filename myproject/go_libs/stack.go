package go_libs

import "fmt"

type Stack struct {
	size int
	root *StackNode
}

type StackNode struct {
	value int
	Next  *StackNode
}

func (s *Stack) Push(value int) bool {
	if s.root == nil {
		(*s) = Stack{size: 1, root: &StackNode{value: value, Next: nil}}
		return true
	}
	temp := &StackNode{value, nil}
	temp.Next = s.root
	(*s).root = temp
	(*s).size++
	return true
}

func (s *Stack) Pop() (int, bool) {
	if s.size == 0 {
		return 0, false
	}
	temp := s.root.value
	if s.size == 1 {
		(*s).size = 0
		(*s).root = nil
		return temp, true
	}
	(*s).root = s.root.Next
	(*s).size--
	return temp, true
}

func (s Stack) TraverseStack() {
	if s.size == 0 {
		fmt.Println("Empty Stack!")
		return
	}

	for s.root != nil {
		fmt.Printf("%d -> ", s.root.value)
		s.root = s.root.Next
	}
	fmt.Println()
}

func InitStack() *Stack {
	return &Stack{size: 0, root: nil}
}
