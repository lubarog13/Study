package game

import (
	"math"
	"reflect"
)

type World struct {
	entities []Enity
}

func (w *World) UpdateWorld() {
	for _, e := range w.entities {
		e.Update()
	}
	for i := len(w.entities) - 1; i >= 0; i-- {
		if (w.entities[i]).GetHealth() <= 0 {
			w.entities = append(w.entities[:i], w.entities[i+1:]...)
		}
	}
}

func InitWorld(entities []Enity) *World {
	return &World{entities: entities}
}

func (w World) GetEntities() []Enity {
	return w.entities
}

func (w *World) GetEntitiesInRegion(x int, z int, ran float64) []Enity {
	entities := make([]Enity, 0)
	for i := 0; i < len(w.entities); i++ {
		radius := math.Sqrt(math.Pow(float64(w.entities[i].GetXPoz()-x), 2) + math.Pow(float64(w.entities[i].GetZPoz()-z), 2))
		w.entities[i].SetRadius(radius)
		if radius <= ran {
			entities = append(entities, w.entities[i])
		}
	}
	return entities
}

func (w *World) GetEntitiesNearEntity(entity Enity, ran float64) []Enity {
	return w.GetEntitiesInRegion(entity.GetXPoz(), entity.GetZPoz(), ran)
}

func (w *World) GetGuardiansInRegion(x int, z int, ran float64) []Enity {
	entities := w.GetEntitiesInRegion(x, z, ran)
	ent := make([]Enity, 0)
	entity := &EntityGuard{}
	for i := len(entities) - 1; i >= 0; i-- {
		if reflect.TypeOf(entities[i]) == reflect.TypeOf(entity) {
			ent = append(ent, entities[i])
		}
	}
	return ent
}
