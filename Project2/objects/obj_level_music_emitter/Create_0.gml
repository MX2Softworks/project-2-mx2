/// Creates the emitter object

level_music_emitter = audio_emitter_create();
audio_falloff_set_model(audio_falloff_none);
audio_play_sound_on(level_music_emitter, snd_level11_music, true, 1);