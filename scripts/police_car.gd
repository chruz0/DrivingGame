extends VehicleBody3D

@export var max_RPM = 800
@export var max_torque = 500
@export var turn_speed = 3
@export var turn_amount = 0.3

func _physics_process(delta: float) -> void:
	$CamArm.position = position
	
	var dir = Input.get_action_strength("moveForward") - Input.get_action_strength("moveBack")
	var steering_dir = Input.get_action_strength("moveLeft") - Input.get_action_strength("moveRight")
	
	var RPM_left = abs($wheel_back_left.get_rpm())
	var RPM_right = abs($wheel_back_right.get_rpm())
	var RPM = (RPM_left + RPM_right) * .5
	
	var torque_factor = pow(1.0 - RPM / max_RPM, 0.6)
	var torque = dir * max_torque * torque_factor
	
	engine_force = torque
	var speed = linear_velocity.length()
	var speed_factor = clamp(1.0 - speed / 40.0, 0.2, 1.0)

	steering = lerp(steering, steering_dir * turn_amount * speed_factor, turn_speed * delta)
