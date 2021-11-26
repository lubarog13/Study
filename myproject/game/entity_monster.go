package game

import (
	"reflect"
)

type EntityMonster struct {
	title     string
	xPoz      int
	zPoz      int
	age       int
	maxHealth float64
	health    float64
	damage    float64
	radius    float64
}

func (b EntityMonster) GetTitle() string {
	return b.title
}

func (b *EntityMonster) SetTitle(title string) {
	(*b).title = title
}

func (b EntityMonster) GetXPoz() int {
	return b.xPoz
}

func (b *EntityMonster) SetXPoz(x int) {
	(*b).xPoz = x
}

func (b EntityMonster) GetZPoz() int {
	return b.zPoz
}

func (b *EntityMonster) SetZPoz(z int) {
	(*b).zPoz = z
}

func (b EntityMonster) GetAge() int {
	return b.age
}

func (b *EntityMonster) SetAge(age int) {
	(*b).age = age
}

func (b EntityMonster) GetMaxHealth() float64 {
	return b.maxHealth
}

func (b *EntityMonster) SetMaxHealth(maxHealth float64) {
	(*b).maxHealth = maxHealth
}

func (b EntityMonster) GetHealth() float64 {
	return b.health
}

func (b *EntityMonster) SetHealth(health float64) {
	(*b).health = health
}

func (b EntityMonster) GetRadius() float64 {
	return b.radius
}

func (b *EntityMonster) SetRadius(radius float64) {
	(*b).radius = radius
}

func (b *EntityMonster) Update() {
	updateEntity(b)
	entities := Server.world.GetEntitiesNearEntity(b, 10000)
	player := &EntityPlayer{}
	rad := 100000.0
	for _, e := range entities {
		if rad > e.GetRadius() && reflect.TypeOf(e) == reflect.TypeOf(player) {
			rad = e.GetRadius()
		}
	}
	for _, e := range entities {
		if reflect.TypeOf(e) == reflect.TypeOf(player) && e.GetRadius() == rad {
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
			if rad <= 2 {
				e.AttackEntityFrom(b, b.damage)
			}
		}
	}
}

func (b *EntityMonster) AttackEntityFrom(e Enity, damage float64) bool {
	return attack(b, e, damage)
}

func InitEntityMonster(title string, xPoz int, zPoz int, age int, maxHealth float64, health float64, damage float64) *EntityMonster {
	return &EntityMonster{title: title, xPoz: xPoz, zPoz: zPoz, age: age, maxHealth: maxHealth, health: health, damage: damage}
}
