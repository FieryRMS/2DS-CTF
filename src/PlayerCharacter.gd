extends CharacterBody2D

var team: int
var character_class: int
var previous_commands: Globals.CharacterCommands
var character_commands_function: Callable

func _init():
	team = Globals.Team.ATTACKER
	character_class = Globals.CharacterClass.ASSAULT


func kbrms_controller():
	var commands: Globals.CharacterCommands = Globals.CharacterCommands.new()
	var up = Input.is_action_pressed("move_up")
	var down = Input.is_action_pressed("move_down")
	var left = Input.is_action_pressed("move_left")
	var right = Input.is_action_pressed("move_right")

	var move = Vector2(0, 0)
	if up and down:
		move = Vector2(0, 0)
	elif up:
		move = Vector2(0, -1)
	elif down:
		move = Vector2(0, 1)

	if left and right:
		move += Vector2(0, 0)
	elif left:
		move += Vector2(-1, 0)
	elif right:
		move += Vector2(1, 0)

	commands.Move = move
	commands.Crosshair = get_local_mouse_position()
	commands.Shoot = Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)

	return commands


func init(tm, char_cls, char_comm_func = kbrms_controller):
	team = tm
	character_class = char_cls
	previous_commands = Globals.CharacterCommands.new()
	character_commands_function = char_comm_func

	if team == Globals.Team.ATTACKER:
		$Team.frame = 0
	else:
		$Team.frame = 1

	if character_class == Globals.CharacterClass.ASSAULT:
		$Class.frame = 2
	elif character_class == Globals.CharacterClass.SNIPER:
		$Class.frame = 3
	elif character_class == Globals.CharacterClass.RUNNER:
		$Class.frame = 4


func _ready():
	pass  # Replace with function body.


func get_character_commands():
	return character_commands_function.call()


func _process(_delta):
	var commands = get_character_commands()

	move_and_collide(commands.Move * Globals.Character)
