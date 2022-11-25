extends KinematicBody2D

var state = MOVE
export var speed: float = 150.0
var velocity: Vector2 = Vector2.ZERO

enum {
	MOVE,
	ATTACK
}

onready var anim_tree := $AnimTree
onready var anim_state = anim_tree.get("parameters/playback")


func _physics_process(delta: float) -> void:
	match state:
		MOVE:
			move_state()
		ATTACK:
			attack_state()

func move_state() -> void:
	# Create the movement input
	var movement_input := Vector2.ZERO
	movement_input.x = Input.get_axis("move_left", "move_right")
	movement_input.y = Input.get_axis("move_up", "move_down")
	
	# If movement input is NOT 0 then add the movement input to veolcity
	if movement_input != Vector2.ZERO:
		anim_tree.set("parameters/Idle/blend_position", movement_input)
		anim_tree.set("parameters/Walk/blend_position", movement_input)
		anim_tree.set("parameters/Attack/blend_position", movement_input)
		anim_state.travel("Walk")
		velocity += movement_input * speed
	# Clamps the multi direction input movement speed
		velocity = velocity.limit_length(speed)
	else:
		anim_state.travel("Idle")
		velocity = Vector2.ZERO
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
	
	move_and_slide(velocity)


func attack_state() -> void:
	velocity = Vector2.ZERO
	anim_state.travel("Attack")


func attack_complete() -> void:
	state = MOVE
