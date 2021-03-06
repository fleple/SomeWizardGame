extends "res://src/Creatures/CreatureWalking.gd"

var MainInstances = ResourceLoader.MainInstances

export (float) var acceleration = 1.5

enum {
	IDLE,
	WALKING,
	CHASING
}

var state = IDLE

func _ready() -> void:
	._ready()
	SPEED = MAX_SPEED

func _physics_process(delta: float) -> void:
	match state:
		IDLE:
			animPlayer.play('nope')
		WALKING:
			walking(delta)
			animPlayer.play('run')
		CHASING:
			chasing(delta)
			animPlayer.play('run')
			
	._physics_process(delta)


func _on_viewport_entered(viewport: Viewport) -> void:
	state = WALKING
	._on_viewport_entered(viewport)


func _on_viewport_exited(viewport: Viewport) -> void:
	state = IDLE
	._on_viewport_exited(viewport)


# warning-ignore:unused_argument
func _on_PlayerDetector_body_entered(body: Node) -> void:
	state = CHASING


# warning-ignore:unused_argument
func _on_PlayerDetector_body_exited(body: Node) -> void:
	state = WALKING


func chasing(delta: float) -> void:
	var player = MainInstances.Player
	sprite.flip_h = global_position > player.global_position
	velocity = move_and_slide(CreatureUtils.chase_object(player, delta, global_position, SPEED, velocity, acceleration))
