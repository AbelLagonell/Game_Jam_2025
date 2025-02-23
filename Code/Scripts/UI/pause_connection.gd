extends CanvasLayer

@export var backBtn: Button = null;
@export var scoreText: Label = null;
@export var pauseText: Label = null;

func _ready() -> void:
	SceneManager.paused.connect(toggle_visibility)
	global.game_end.connect(_on_end)
	
func toggle_visibility():
	visible = !visible

func _on_back_pressed() -> void:
	SceneManager.toggle_pause();

func _on_end():
	toggle_visibility()
	backBtn.visible=false;
	pauseText.text = "Game Over"
	scoreText.text = "%d" % global.get_score();
