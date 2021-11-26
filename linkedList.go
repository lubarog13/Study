package main

import (
	"fmt"
)

type Node struct {
	Value int
	Next  *Node
}

var root = new(Node)
var newRoot = new(Node)

func addNode(t *Node, v int) int {
	if root == nil {
		t = &Node{v, nil}
		root = t
		return 0
	}

	if v == t.Value {
		fmt.Println("Node already exists: ", v)
		return -1
	}

	if t.Next == nil {
		t.Next = &Node{v, nil}
		return -2
	}

	return addNode(t.Next, v)
}

func addSorted(t *Node, v int) int {
	if root == nil {
		t = &Node{v, nil}
		root = t
		return 0
	}
	if v == t.Value {
		fmt.Println("Node already exists: ", v)
		return -1
	}
	if t.Value > v {
		fmt.Println("Value is too small for this list")
		return -2
	}

	if t.Next == nil {
		t.Next = &Node{v, nil}
		return -3
	}

	if t.Next.Value > v {
		t.Next = &Node{v, t.Next}
		return -4
	}
	return addSorted(t.Next, v)
}

func traverse(t *Node) {
	if t == nil {
		fmt.Println("-> Empty list!")
		return
	}

	for t != nil {
		fmt.Printf("%d -> ", t.Value)
		t = t.Next
	}
	fmt.Println()
}

func lookupNode(t *Node, v int) bool {
	if root == nil {
		t = &Node{v, nil}
		root = t
		return false
	}
	if v == t.Value {
		return true
	}

	if t.Next == nil {
		return false
	}

	return lookupNode(t.Next, v)
}

func size(t *Node) int {
	if t == nil {
		fmt.Println("-> Empty list!")
		return 0
	}

	i := 0
	for t != nil {
		i++
		t = t.Next
	}
	return i
}

func main() {
	fmt.Println(root)
	root = nil
	traverse(root)
	addSorted(root, 1)
	addSorted(root, -1)
	traverse(root)
	addSorted(root, 10)
	addSorted(root, 5)
	addSorted(root, 45)
	addSorted(root, 5)
	addSorted(root, 5)
	traverse(root)
	addSorted(root, 30)
	traverse(root)
	if lookupNode(root, 30) {
		fmt.Println("Node exists!")
	} else {
		fmt.Println("Node does not exists!")
	}
	if lookupNode(root, -100) {
		fmt.Println("Node exists!")
	} else {
		fmt.Println("Node does not exists!")
	}
}
