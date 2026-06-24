extends Node2D

var meteor_scene: PackedScene = load("res://scenes/meteor.tscn")
var laser_scene: PackedScene = load("res://scenes/laser.tscn")

var health: int = 3

func _ready() -> void:
	
	get_tree().call_group('ui', 'set_health', health)
	var size := get_viewport().get_visible_rect().size
	var rng := RandomNumberGenerator.new()
	for star in $Stars.get_children():
		var random_x = rng.randi_range(0,size.x)
		var random_y = rng.randi_range(0,size.y)
		star.position = Vector2(random_x, random_y)

		var random_scale = rng.randf_range(0.7,1)
		star.scale = Vector2(random_scale,random_scale)
		
		star.speed_scale = rng.randf_range(0.6,1.4)
		
		
func _on_meteor_timer_timeout() -> void:
	var meteor = meteor_scene.instantiate()
	
	$Meteors.add_child(meteor)
	meteor.connect('collision', on_meteor_collision)
	
func on_meteor_collision():
	health -= 1
	get_tree().call_group('ui', 'set_health', health)
	if health <= 0:
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
		$Player.play_collision_sound()
func _on_player_laser(pos) -> void:
	var laser = laser_scene.instantiate()
	$Lasers.add_child(laser)
	laser.position = pos
	
