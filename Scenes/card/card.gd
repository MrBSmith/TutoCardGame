extends Control
class_name Card

enum STATE {
	IN_HAND,
	DRAG,
	ON_BOARD,
}

@export_range(0.0, 200.0) var hovered_offset = 60.0
@onready var pivot: Control = $Pivot
@onready var panel : Panel = %Panel
@export var state : STATE = STATE.IN_HAND

var hovered := false

func _ready() -> void:
	panel.mouse_entered.connect(mouse_entered.emit)	
	panel.mouse_exited.connect(mouse_exited.emit)	
	panel.gui_input.connect(_on_Panel_gui_input)


func _process(_delta: float) -> void:
	match(state):
		STATE.IN_HAND:
			var dest = -hovered_offset if hovered else 0.0
			pivot.position.y = lerp(pivot.position.y, dest, 0.2)
		STATE.DRAG:
			var mouse_pos = get_global_mouse_position()
			pivot.position = Vector2.ZERO
			global_position = mouse_pos


func _on_Panel_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			if state == STATE.IN_HAND:
				state = STATE.DRAG
		else:
			if state == STATE.DRAG:
				state = STATE.IN_HAND



func _on_panel_gui_input(_event: InputEvent) -> void:
	pass # Replace with function body.
