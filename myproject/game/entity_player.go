package game

type EntityPlayer struct {
	title     string
	xPoz      int
	zPoz      int
	age       int
	maxHealth float64
	health    float64
	exp       int
	radius    float64
}

var Server = InitServer(nil)

func (b EntityPlayer) GetTitle() string {
	return b.title
}

func (b *EntityPlayer) SetTitle(title string) {
	(*b).title = title
}

func (b EntityPlayer) GetXPoz() int {
	return b.xPoz
}

func (b *EntityPlayer) SetXPoz(x int) {
	(*b).xPoz = x
}

func (b EntityPlayer) GetZPoz() int {
	return b.zPoz
}

func (b *EntityPlayer) SetZPoz(z int) {
	(*b).zPoz = z
}

func (b EntityPlayer) GetAge() int {
	return b.age
}

func (b *EntityPlayer) SetAge(age int) {
	(*b).age = age
}

func (b EntityPlayer) GetMaxHealth() float64 {
	return b.maxHealth
}

func (b *EntityPlayer) SetMaxHealth(maxHealth float64) {
	(*b).maxHealth = maxHealth
}

func (b EntityPlayer) GetHealth() float64 {
	return b.health
}

func (b *EntityPlayer) SetHealth(health float64) {
	(*b).health = health
}
func (b EntityPlayer) GetRadius() float64 {
	return b.radius
}

func (b *EntityPlayer) SetRadius(radius float64) {
	(*b).radius = radius
}

func (b *EntityPlayer) Update() {
	updateEntity(b)
	if Server.updateCounter%2 == 0 && b.health < b.maxHealth {
		b.health++
	}
}

func (b *EntityPlayer) AttackEntityFrom(e Enity, damage float64) bool {
	entities := Server.GetWorld().GetGuardiansInRegion(b.xPoz, b.zPoz, 2)
	if len(entities) > 0 {
		for _, en := range entities {
			en.AttackEntityFrom(e, (damage / float64(len(entities))))
		}
		return false
	}
	if attack(b, e, damage) {
		return true
	}
	if e.AttackEntityFrom(b, b.calculateDamage()) {
		b.exp++
		return false

	}
	return false
}

func InitEntityPlayer(title string, xPoz int, zPoz int, age int, maxHealth float64, health float64, exp int) *EntityPlayer {
	return &EntityPlayer{title: title, xPoz: xPoz, zPoz: zPoz, age: age, maxHealth: maxHealth, health: health, exp: exp}
}

func (p EntityPlayer) calculateDamage() float64 {
	return float64(3 + p.exp/2)
}
