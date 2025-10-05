extends PathFollow2D

@export var segment_scene: PackedScene
@export var segment_count: int = 10
@export var segment_spacing: float = 20.0
@export var tail_scale_segments: int = 3 
@export var speed: float = 100.0

var segments: Array[PathFollow2D] = []

func _ready():
	z_index = segment_count
	
	create_segments()

func create_segments():
	var path = get_parent()
	
	for i in range(segment_count):
		var segment = segment_scene.instantiate() as PathFollow2D
		
		path.add_child.call_deferred(segment)
		segments.append(segment)
		
		setup_segment.call_deferred(segment, i)

func setup_segment(segment: PathFollow2D, index: int):
	segment.progress = progress - (segment_spacing * (index + 1))
	
	var body = segment.get_node("Body")
	body.rotation = randf_range(0, TAU)
	
	if index >= segment_count - tail_scale_segments:
		segment.scale = Vector2(lerp(1.0, 0.5, (index - (segment_count - tail_scale_segments)) / float(tail_scale_segments)), lerp(1.0, 0.5, (index - (segment_count - tail_scale_segments)) / float(tail_scale_segments)))
	
	segment.z_index = segment_count - (index + 1)

func _process(_delta):
	progress += speed * _delta
	for i in range(segments.size()):
		segments[i].progress = progress - (segment_spacing * (i + 1))

func destroy_segments():
	for segment in segments:
		segment.queue_free()
	segments.clear()
