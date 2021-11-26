package game

import (
	"reflect"
	"sort"
)

type EntityGuard struct {
	title     string
	xPoz      int
	zPoz      int
	age       int
	maxHealth float64
	health    float64
	radius    float64
}

func (b EntityGuard) GetTitle() string {
	return b.title
}

func (b *EntityGuard) SetTitle(title string) {
	(*b).title = title
}

func (b EntityGuard) GetXPoz() int {
	return b.xPoz
}

func (b *EntityGuard) SetXPoz(x int) {
	(*b).xPoz = x
}

func (b EntityGuard) GetZPoz() int {
	return b.zPoz
}

func (b *EntityGuard) SetZPoz(z int) {
	(*b).zPoz = z
}

func (b EntityGuard) GetAge() int {
	return b.age
}

func (b *EntityGuard) SetAge(age int) {
	(*b).age = age
}

func (b EntityGuard) GetMaxHealth() float64 {
	return b.maxHealth
}

func (b *EntityGuard) SetMaxHealth(maxHealth float64) {
	(*b).maxHealth = maxHealth
}

func (b EntityGuard) GetHealth() float64 {
	return b.health
}

func (b *EntityGuard) SetHealth(health float64) {
	(*b).health = health
}

func (b EntityGuard) GetRadius() float64 {
	return b.radius
}

func (b *EntityGuard) SetRadius(radius float64) {
	(*b).radius = radius
}

func (b *EntityGuard) Update() {
	updateEntity(b)
	entities := Server.world.GetEntitiesNearEntity(b, 10000)
	slice := make([]Enity, len(entities))
	copy(slice, entities)
	sort.Slice(slice, func(i, j int) bool {
		return slice[i].GetRadius() < slice[j].GetRadius()
	})
	player := &EntityPlayer{}
	for _, e := range slice {
		if reflect.TypeOf(e) == reflect.TypeOf(player) {
			if b.xPoz > e.GetXPoz() {
				b.xPoz--
			} else if b.xPoz < e.GetXPoz() {
				b.xPoz++
			}
			if b.zPoz > e.GetZPoz() {
				b.zPoz--
			} else if b.zPoz < e.GetZPoz() {
				b.zPoz++
			}
			return
		}
	}
}

func (b *EntityGuard) AttackEntityFrom(e Enity, damage float64) bool {
	return attack(b, e, damage)
}

func InitEntityGuard(title string, xPoz int, zPoz int, age int, maxHealth float64, health float64) *EntityGuard {
	return &EntityGuard{title: title, xPoz: xPoz, zPoz: zPoz, age: age, maxHealth: maxHealth, health: health}
}
