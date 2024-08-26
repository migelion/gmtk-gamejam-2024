extends VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match Global.game_mode:
		Global.GameMode.SURVIVAL:
			visible = false
		Global.GameMode.CHARGE:
			visible = true
			Events.charge_changed.connect(_charge_changed)
			$Positive.max_value = Global.max_charge
			$Negative.max_value = abs(Global.min_charge)

func _charge_changed(charge: float) -> void:
	$Positive.value = charge
	$Negative.value = -charge
