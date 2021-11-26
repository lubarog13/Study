package game

type GameServer struct {
	world         *World
	updateCounter int
}

func (g *GameServer) UpdateServer() {
	g.updateCounter++
	g.world.UpdateWorld()
}

func (g GameServer) GetWorld() *World {
	return g.world
}

func (g GameServer) GetCounter() int {
	return g.updateCounter
}

func InitServer(w *World) *GameServer {
	return &GameServer{world: w, updateCounter: 0}
}

func (g *GameServer) SetWorld(w World) {
	g.world = &w
}
