extends AudioStreamPlayer

var debug: bool = false

const menu_music = preload("res://audio/20241029-game-test.ogg")

#sfx connection
var RandomWinStatementsKatalog
var RamdomLooseStatementKatalog
var WinStatement :AudioStream
var LooseStatement :AudioStream
var FinaLooseStatement :AudioStream = load("res://audio/loose/loose_final.wav")

#random generator
var rng = RandomNumberGenerator.new()

func _ready():
	if debug: print("audioplayer ready")
	RandomWinStatementsKatalog = Global.WinStatements
	RamdomLooseStatementKatalog = Global.LooseStatements

func _play_music(music: AudioStream, volume=-12.0):
	if stream == music: 
		return
	
	stream = music
	volume_db = volume
	play()
	
func play_music_menu():
	_play_music(menu_music)
	
func play_win_sfx():
	var rn = rng.randi_range(0, RandomWinStatementsKatalog.size()-1)
	if debug: print("sfxwin:"+str(RandomWinStatementsKatalog[rn]))
	var WinStatement = load(RandomWinStatementsKatalog[rn])
	play_sfx(WinStatement)
	
func play_loose_sfx():
	var rn = rng.randi_range(0, RamdomLooseStatementKatalog.size()-1)
	if debug: print("sfxloose:"+str(RamdomLooseStatementKatalog[rn]))
	var WinStatement = load(RamdomLooseStatementKatalog[rn])
	play_sfx(WinStatement)
	play_sfx(FinaLooseStatement)

func play_sfx(stream:AudioStream, volume=-12.0):
	var fx_player = AudioStreamPlayer.new()
	fx_player.stream=stream
	fx_player.name="FX_PLAYER"
	fx_player.volume_db = volume
	add_child(fx_player)
	fx_player.play()
	
	await fx_player.finished
	fx_player.queue_free()
	
