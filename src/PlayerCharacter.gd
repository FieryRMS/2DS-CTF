extends CharacterBody2D

var BulletSprite = preload("res://sprites/bullet.tscn")

var team: Globals.Team
var character: Globals.Character
var previous_commands: Globals.CharacterCommands
var character_commands_function: Callable
var is_inited = false


func init(tm, char_cls, char_comm_func):
	is_inited = true
	team = tm
	character = Globals.Character.new(char_cls)
	previous_commands = Globals.CharacterCommands.new()
	character_commands_function = char_comm_func

	if team == Globals.Team.ATTACKER:
		$Team.frame = 0
		add_to_group("attacker")
		set_collision_layer_value(1, true)
	else:
		$Team.frame = 1
		add_to_group("defender")
		set_collision_layer_value(2, true)

	if char_cls == Globals.CharacterClass.ASSAULT:
		$CharacterClass.frame = 2
	elif char_cls == Globals.CharacterClass.SNIPER:
		$CharacterClass.frame = 3
	elif char_cls == Globals.CharacterClass.RUNNER:
		$CharacterClass.frame = 4

	$Firerate.wait_time = 1.0 / character.firerate


func _ready():
	if not is_inited:
		init(Globals.Team.DEFENDER, Globals.CharacterClass.RUNNER, kbrms_controller)


func get_character_commands():
	return character_commands_function.call()


func _process(delta):
	var commands = get_character_commands()

	move_and_collide(commands.Move * character.movementspeed * delta)
	self.rotation += calc_del_rotation(commands.Crosshair, delta)

	if commands.Shoot and $Firerate.is_stopped():
		var bullet = BulletSprite.instantiate()
		var pos = global_position + Vector2(0, -16).rotated(rotation)
		bullet.init(team, pos, rotation, character.bulletspeed, character.damage)
		get_parent().add_child(bullet)
		$Firerate.start()


# utility functions
func calc_del_rotation(mouse_pos, delta):
	var mouse_dir = mouse_pos - global_position
	var mouse_angle = mouse_dir.angle() + PI / 2
	var delta_angle = mouse_angle - self.rotation
	if delta_angle > PI:
		delta_angle -= 2 * PI
	elif delta_angle < -PI:
		delta_angle += 2 * PI
	var max_change = character.rotationspeed * delta
	if abs(delta_angle) > max_change:
		delta_angle = sign(delta_angle) * max_change
	return delta_angle


func kbrms_controller():
	var commands: Globals.CharacterCommands = Globals.CharacterCommands.new()

	var move = Vector2(0, 0)
	if Input.is_action_pressed("move_up"):
		move.y -= 1
	if Input.is_action_pressed("move_down"):
		move.y += 1
	if Input.is_action_pressed("move_left"):
		move.x -= 1
	if Input.is_action_pressed("move_right"):
		move.x += 1

	commands.Move = move
	commands.Crosshair = get_global_mouse_position()
	commands.Shoot = Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)

	return commands


func take_damage(damage):
	character.health -= damage
	if character.health <= 0:
		queue_free()
