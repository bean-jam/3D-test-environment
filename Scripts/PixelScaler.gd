extends Control

# Base resolution your game is authored at
@export var base_resolution: Vector2i = Vector2i(1920, 1080)

# Chunkiness at base resolution
@export_range(1, 12, 1) var base_pixel_scale := 4

# Minimum/maximum pixel scale
@export_range(1, 12, 1) var min_pixel_scale := 3
@export_range(1, 12, 1) var max_pixel_scale := 8

# Step size for chunky scaling
@export_range(1, 4, 1) var step_size := 1

@onready var container := $SubViewportContainer

func _process(_delta):
	if container == null:
		return

	var window_size = get_window().size
	var window_min = min(window_size.x, window_size.y)
	var base_min = min(base_resolution.x, base_resolution.y)

	# Scale proportionally to window size
	var target_scale = base_pixel_scale * window_min / base_min

	# Round to nearest step for chunky pixels
	var pixel_scale = int((target_scale + step_size * 0.5) / step_size) * step_size

	# Clamp to min/max
	pixel_scale = clamp(pixel_scale, min_pixel_scale, max_pixel_scale)

	container.stretch_shrink = pixel_scale
