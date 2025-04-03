extends Node3D
class_name PlayerFollower


@export var lerp_speed: float = 3.0

@export_group("min & max rotations")
@export var X: Vector2 = Vector2(-20.0, 20.0)
@export var Y: Vector2 = Vector2(-20.0, 20.0)
@export var Z: Vector2 = Vector2(-20.0, 20.0)


@onready var _dummy = Node3D.new()
func _ready() -> void:
	self.add_child(_dummy)

# Function to clamp a Vector3 to the specified ranges
func clamp_vector3(vec: Vector3, x: Vector2, y: Vector2, z: Vector2) -> Vector3:
	return Vector3(clamp(vec.x, x.x, x.y), clamp(vec.y, y.x, y.y), clamp(vec.z, z.x, z.y))

# Smoothly follow the target using lerping for rotation
func update_target_following(target: Node3D) -> void:
	_dummy.look_at(target.position)
	
	var current_rotation = rotation.y
	var new_rotation = lerp_angle(current_rotation, _dummy.rotation.y, lerp_speed * get_process_delta_time())
	
	# Set the new smoothed rotation while clamping
	rotation.y = new_rotation
	#rotation = clamp_vector3(rotation, X, Y, Z)

# Smoothly reset rotation to (0, 0, 0)
func rest() -> void:
	rotation = Vector3(
		lerp_angle(rotation.x, 0.0, lerp_speed * get_process_delta_time()),
		lerp_angle(rotation.y, 0.0, lerp_speed * get_process_delta_time()),
		lerp_angle(rotation.z, 0.0, lerp_speed * get_process_delta_time())
	)
	rotation = clamp_vector3(rotation, X, Y, Z)
