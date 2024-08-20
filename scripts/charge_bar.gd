extends VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match Global.game_mode:
		Global.GameMode.SURVIVAL:
			visible = false
		Global.GameMode.CHARGE:
			visible = true
			Global.charge_changed.connect(_charge_changed)

func _charge_changed(charge: float) -> void:
	$Positive.value = charge
	$Negative.value = -charge
