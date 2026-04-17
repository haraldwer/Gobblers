extends Node3D

@export_range(0.1, 3, 0.1) var duration: float = 0.5 # m/s
@export_range(0, 1, 0.2) var damage_part: float = 0.5 # m/s
@export var query_shape: SphereShape3D

var cooldown: float
@onready var character: CharacterBody3D = $".."

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if Input.is_action_just_pressed(&"attack"):
		_begin_attack()
	if cooldown > 0:
		_perform_attack(delta)
		
	pass

func _begin_attack() -> void:
	if cooldown > 0:
		pass
	cooldown = duration

func _perform_attack(delta: float) -> void:
	
	cooldown -= delta
	var part = 1 - cooldown / duration
	
	if part > damage_part:
		var space_state = get_world_3d().direct_space_state
		var params = PhysicsShapeQueryParameters3D.new() 
		params.set_shape(query_shape)
		params.transform = global_transform
		var result = space_state.intersect_shape(params)
		
		if result:
			for r in result:
				var collider_parent = r.collider
				if collider_parent is Enemy: 
					_deal_damage(collider_parent)
	pass
	
func _deal_damage(enemy: Enemy) -> void:
	enemy.damage(character)
	pass
