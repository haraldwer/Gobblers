extends CharacterBody3D

var player: Node3D

@export_range(1, 35, 1) var speed: float = 3 # m/s
@export_range(1, 400, 1) var acceleration: float = 10 # m/s^2

var grav_vel: Vector3
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var move_vel: Vector3

func _process(delta: float) -> void:
	if not player:
		player = get_tree().get_nodes_in_group("Player")[0]

func _physics_process(delta: float) -> void:
	velocity = _walk(delta) + _gravity(delta);
	move_and_slide()

func _walk(delta: float) -> Vector3:
	if player:
		var diff = player.position - position
		var dir = diff.normalized() * Vector3(1, 0, 1)
		move_vel = move_vel.move_toward(dir * speed, acceleration * delta)
	return move_vel

func _gravity(delta: float) -> Vector3:
	grav_vel = Vector3.ZERO if is_on_floor() else grav_vel.move_toward(Vector3(0, velocity.y - gravity, 0), gravity * delta)
	return grav_vel
