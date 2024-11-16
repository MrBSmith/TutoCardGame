extends Control
class_name Hand

@onready var cards_container: Control = %Cards

signal hovered_card_changed

var hovered_card: Card = null:
	set(value):
		if value != hovered_card:
			hovered_card = value
			hovered_card_changed.emit()


func _ready() -> void:
	hovered_card_changed.connect(_update_card_hover)
	var hover_fn = func(card: Card): hovered_card = card
	var unhover_fn = func(card: Card): 
		if hovered_card == card: 
			hovered_card = null
	
	for card in cards_container.get_children():
		card.mouse_entered.connect(hover_fn.bind(card))
		card.mouse_exited.connect(unhover_fn.bind(card))


func _process(_delta: float) -> void:
	var cards = cards_container.get_children()
	
	for i in range(cards.size()):
		var card = cards[i]
		
		if card.state != Card.STATE.IN_HAND:
			continue

		var offset = cards_container.size.x / (cards.size() + 1)
		card.position.x = lerp(card.position.x, offset * (i + 1), 0.3)
		card.position.y = cards_container.size.y / 2.0


func _update_card_hover() -> void:
	for card in cards_container.get_children():
		card.hovered = card == hovered_card
