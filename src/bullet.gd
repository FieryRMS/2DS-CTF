extends RigidBody2D

var team: Globals.Team
var damage: int
var speed: float


func init(tm: Globals.Team, glob_pos: Vector2, rot: float, spd: float, dmg: int):
	team = tm
	position = glob_pos
	damage = dmg
	speed = spd
	rotation = rot
	if team == Globals.Team.ATTACKER:
		set_collision_mask_value(2, true)
	else:
		set_collision_mask_value(1, true)


func _process(delta):
	var collision: KinematicCollision2D = move_and_collide(
		Vector2(speed * delta, 0).rotated(rotation - PI / 2)
	)

	if collision:
		var obj: Object = collision.get_collider()
		if obj.is_in_group("character") and obj.team != team:
			obj.take_damage(damage)
		queue_free()

	if (
		position.x < 0
		or position.x > get_viewport_rect().size.x
		or position.y < 0
		or position.y > get_viewport_rect().size.y
	):
		queue_free()
	pass
