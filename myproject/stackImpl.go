package main

import (
	"fmt"
	"myproject/game"
)

func main() {
	/* stack1 := stack.InitStack()
	stack1.TraverseStack()
	for i := 0; i < 10; i++ {
		stack1.Push(i)
	}
	stack1.TraverseStack()
	stack1.Pop()
	stack1.TraverseStack() */
	GameServ := game.InitServer(game.InitWorld(nil))
	entity := game.InitEntityMonster("Wolf", 20, 20, 10, 100.0, 80.0, 20)
	entities := make([]game.Enity, 0)
	entities = append(entities, entity)
	entities = append(entities, game.InitEntityGuard("Elf", 40, 60, 100, 40.0, 30.0))
	entities = append(entities, game.InitEntityGuard("COw", 25, 20, 100, 40.0, 30.0))
	entities = append(entities, game.InitEntityPlayer("Me", 20, 21, 20, 100.0, 80.0, 2))
	world := game.InitWorld(entities)
	GameServ.SetWorld(*world)
	game.Server = GameServ
	for i := 0; i < 10; i++ {
		GameServ.UpdateServer()
		for _, e := range GameServ.GetWorld().GetEntities() {
			fmt.Print(e, " ")
		}
		fmt.Println()
	}
}
