extends CharacterBody2D

@export var speed: int = 500
var can_shoot: bool = true

signal laser(pos)


func _ready() -> void:
	position = Vector2(100,500) 



func _process(_delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed
	move_and_slide()

	if Input.is_action_just_pressed("shoot") and can_shoot:
		laser.emit($LaserStartpos.global_position)
		can_shoot = false
		$LaserTimer.start()
		$LaserSound.play()

func play_collision_sound():
	$DamageSound.play()
	
func _on_laser_timer_timeout() -> void:
	can_shoot = true
	
