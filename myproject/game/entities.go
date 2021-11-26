package game

import "fmt"

type Enity interface {
	GetTitle() string
	SetTitle(title string)
	GetXPoz() int
	SetXPoz(x int)
	GetZPoz() int
	SetZPoz(z int)
	GetAge() int
	SetAge(age int)
	GetMaxHealth() float64
	SetMaxHealth(maxHealth float64)
	GetHealth() float64
	SetHealth(health float64)
	GetRadius() float64
	SetRadius(radius float64)
	Update()
	AttackEntityFrom(e Enity, damage float64) bool
}

type BaseEntity struct {
	title     string
	xPoz      int
	zPoz      int
	age       int
	maxHealth float64
	health    float64
	radius    float64
}

func (b BaseEntity) GetTitle() string {
	return b.title
}

func (b *BaseEntity) SetTitle(title string) {
	(*b).title = title
}

func (b BaseEntity) GetXPoz() int {
	return b.xPoz
}

func (b *BaseEntity) SetXPoz(x int) {
	(*b).xPoz = x
}

func (b BaseEntity) GetZPoz() int {
	return b.zPoz
}

func (b *BaseEntity) SetZPoz(z int) {
	(*b).zPoz = z
}

func (b BaseEntity) GetAge() int {
	return b.age
}

func (b *BaseEntity) SetAge(age int) {
	(*b).age = age
}

func (b BaseEntity) GetMaxHealth() float64 {
	return b.maxHealth
}

func (b *BaseEntity) SetMaxHealth(maxHealth float64) {
	(*b).maxHealth = maxHealth
}

func (b BaseEntity) GetHealth() float64 {
	return b.health
}

func (b *BaseEntity) SetHealth(health float64) {
	(*b).health = health
}

func (b BaseEntity) GetRadius() float64 {
	return b.radius
}

func (b *BaseEntity) SetRadius(radius float64) {
	(*b).radius = radius
}

func updateEntity(e Enity) {
	e.SetAge(e.GetAge() + 1)
}

func (b *BaseEntity) Update() {
	updateEntity(b)
}

func attack(e Enity, a Enity, damage float64) bool {
	e.SetHealth(e.GetHealth() - damage)
	if e.GetHealth() <= 0 {
		fmt.Println(a, "убил", e)
		return true
	}
	return false
}

func (b *BaseEntity) AttackEntityFrom(e Enity, damage float64) bool {
	return attack(b, e, damage)
}

func InitBaseEntity(title string, xPoz int, zPoz int, age int, maxHealth float64, health float64) *BaseEntity {
	return &BaseEntity{title: title, xPoz: xPoz, zPoz: zPoz, age: age, maxHealth: maxHealth, health: health}
}
