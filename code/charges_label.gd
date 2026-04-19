extends Label

func _ready():
	Global.on_charges_changed.connect(func(charges, max_charges):
		text = "Charges Remaining: %s / %s" % [charges, max_charges]
		)
	text = "Charges Remaining: %s / %s" % [Global.current_charges, Global.max_charges]
