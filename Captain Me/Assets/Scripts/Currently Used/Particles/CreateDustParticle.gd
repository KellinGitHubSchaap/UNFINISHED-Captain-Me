extends Spatial

export (PackedScene) var _particlePrefab
export var _timeTillNextParticle : float

onready var _timer = $Timer
onready var _dustSpawnPos = get_parent().get_node("Player/Owl/Dust Trail Pos")

func _ready():
	_timer.wait_time = _timeTillNextParticle

func SpawnNewDustTrail():
	var dust = _particlePrefab.instance()
	add_child(dust)
	dust.translation = _dustSpawnPos.global_transform.origin
	dust.emitting = true
	_timer.wait_time = _timeTillNextParticle
