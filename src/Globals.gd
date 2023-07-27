class_name Globals

enum Team { ATTACKER, DEFENDER }
enum CharacterClass { ASSAULT, SNIPER, RUNNER }

const friendly_fire = false


class Character:
	var character_class: CharacterClass
	var movementspeed := 100
	var rotationspeed := 5
	var damage := 1
	var basespread := 1
	var spreadmultiplier := 1
	var spreadrecoveryspeed := 1
	var firerate := 5.0
	var viewdistance := 1
	var viewangle := 1
	var bulletspeed := 100
	var health := 1

	func _init(chr_cls):
		self.character_class = chr_cls
		pass


class CharacterCommands:
	var Move: Vector2 = Vector2(0, 0)
	var Crosshair: Vector2 = Vector2(0, 0)
	var Shoot: bool = false

	func _set(property, value):
		match property:
			"Move":
				if value.length() > 1:
					value.normalize()
				Move = value
			"Crosshair":
				Crosshair = value
			"Shoot":
				Shoot = value
