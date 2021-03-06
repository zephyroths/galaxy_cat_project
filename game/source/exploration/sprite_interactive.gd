extends SpriteActor
class_name SpriteInteractive

signal interaction_finished(pawn)

export var vanish_on_interaction: = false
export var AUTO_START_INTERACTION: = false
export var sight_distance = 50

onready var area = $area

func _ready():
	area.connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body: PhysicsBody) -> void:
	if body.is_in_group("player"):
		if AUTO_START_INTERACTION:
			start_interaction()
		else:
			print("MANUAL")

func start_interaction() -> void:
	get_tree().paused = true
	var actions = $actions.get_children()
	for action in actions:
		action.interact()
		yield(action, "finished")
	emit_signal("interaction_finished", self)
	if vanish_on_interaction:
		queue_free()
	get_tree().paused = false
