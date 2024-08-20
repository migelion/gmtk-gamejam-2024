extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.charge_changed.connect(_charge_changed)

func _charge_changed(charge: float) -> void:
	$Positive.value = charge
	$Negative.value = -charge

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
