extends AudioStreamPlayer

const level_music = preload("res://audio/20241029-game-test.ogg")

func _play_music(music: AudioStream, volume=-12.0):
	if stream == music: return
	
	stream = music
	volume_db = volume
	play()
	
func play_music_level():
	_play_music(level_music)


func play_fx(strem:AudioStream, volume=-12.0):
	var fx_player = AudioStreamPlayer.new()
	fx_player.stream=stream
	fx_player.name="FX_PLAYER"
	fx_player.volume_db = volume
	add_child(fx_player)
	fx_player.play()
	
	await fx_player.finished
	fx_player.queue_free()
	
