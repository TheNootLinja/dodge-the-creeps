extends Node

@export var mob_scene: PackedScene
var score


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_hit() -> void:
	pass # Replace with function body.


func game_over() -> void:
	$ScoreTimer.stop()
	$MobTImer.stop()
	
func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()

func _on_score_timer_timeout() -> void:
	score += 1

func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()
	
func _on_mob_timer_timeout() -> void:
	# Creates a new isntance of the mob scene
	var mob = mob_scene.instantiate()
	
	# Choose a random location on Path2d
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	
	# Set the mobs position to the randomly generated location
	mob.position = mob_spawn_location.position
	
	# Set the mobs direction perpendicular to the path direction
	var direction = mob_spawn_location.rotation + PI / 2
	
	# Randomly determine direction
	direction += randf_range(-PI /4, PI / 4)
	mob.rotation = direction
	
	# Decide how fast the mob is moving
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	# Spawn mob by adding to main scene
	add_child(mob)
	
	
