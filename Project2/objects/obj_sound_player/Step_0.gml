/// @description  Play background music

// Start soundtrack

if (!audio_is_playing(snd_soundtrack)) {
    audio_emitter_gain(audio_em, .15);
    audio_play_sound_on(audio_em, snd_soundtrack, true, 12);
    
}

