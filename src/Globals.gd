class_name Globals

enum Team { ATTACKER, DEFENDER }
enum CharacterClass { ASSAULT, SNIPER, RUNNER }


class Character:
	var movementspeed = 1
	var rotationspeed = 1
	var damage = 1
	var basespread = 1
	var spreadmultiplier = 1
	var spreadrecoveryspeed = 1
	var firerate = 1
	var viewdistance = 1
	var viewangle = 1
	var bulletspeed = 1
	var health = 1

	func _init(_character_class):
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
