extends Control
class_name Card

@export_range(0.0, 200.0) var hovered_offset = 60.0
@onready var pivot: Control = $Pivot

var hovered := false


func _process(delta: float) -> void:
	var dest = -hovered_offset if hovered else 0.0
	pivot.position.y = lerp(pivot.position.y, dest, 0.2)


func _on_panel_mouse_entered() -> void:
	mouse_entered.emit()


func _on_panel_gui_input(event: InputEvent) -> void:
	pass # Replace with function body.
