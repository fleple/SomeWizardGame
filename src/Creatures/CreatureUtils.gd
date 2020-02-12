extends Node

const GREEN = Color8(0, 255, 0, 255)
const YELLOW = Color8(255, 255, 0, 255)
const BLUE = Color8(0, 0, 255, 255)
const NOT_COLORED = Color8(255, 255, 255, 255)


func get_walk_velocity(move: String, speed: int, direction: int) -> Vector2:
	match move:
		'horizontal':
			return Vector2(speed * direction, 0)
		'vertical':
			return Vector2(0, speed * direction)
	
	return Vector2.ZERO


func get_diagonal_walk_velocity(move: String, speed: int, direction: int) -> Vector2:
	match move:
		'to_up_right':
			return Vector2(speed * direction, speed * direction)
		'to_bottom_left':
			return Vector2(speed * -direction, speed * direction)
	
	return Vector2.ZERO


func get_rand_elem(options: Array) -> String:
	return options[rand_range(0, options.size())]


func get_state_color(state: Dictionary) -> Color:
	if state.poisoned and state.freezed:
		return YELLOW
	elif state.poisoned:
		return GREEN
	elif state.freezed:
		return BLUE
	
	return NOT_COLORED


func chase_object(
	object: KinematicBody2D,
	delta: float,
	position: Vector2,
	speed: int,
	velocity: Vector2
	) -> Vector2:
	var direction = object.global_position - position
	velocity += (direction * speed * delta)
	velocity = velocity.clamped(speed * rand_range(1.3, 1.5))
	return velocity
