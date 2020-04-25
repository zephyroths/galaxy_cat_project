extends Position2D
class_name Fighter

signal dead(fighter)

export var TARGET_OFFSET_DISTANCE: float = 120.0

export var stats: Resource
onready var skin = $skin
onready var bars = $bars
onready var actions = $actions
onready var skills = $skills
onready var ai = $ai

onready var target_global_position: Vector2 = $anchor.global_position

var selected: bool = false setget set_selected
var selectable: bool = false setget set_selectable

export var party_member: bool = false
export var turn_icon: Texture

func _ready():
	selectable = true

func initialize():
	skin.play()
	actions.initialize(skills.get_children())
	stats = stats.copy()
	stats.connect("health_depleted", self, "_on_health_depleted")

func is_able_to_play() -> bool:
	return stats.health > 0

func set_selected(value):
	selected = value

func set_selectable(value):
	selectable = value
	if not selectable:
		set_selected(false)

func take_damage(hit):
	stats.take_damage(hit)
	if stats.health > 0:
		pass

func _on_health_depleted():
	selectable = false
	emit_signal("dead", self)

func has_point(point: Vector2):
	print(point)
