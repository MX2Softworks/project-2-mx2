/// @description Insert description here

if(place_meeting(x, y, obj_player)) 
{
	pushed = 1;
	
	image_index = 1;
	
	if(play_audio == 0)
	{
		audio_play_sound_on(obj_switch_emitter.switch_emitter, snd_switch, false, 1);
		play_audio = 1;
	}
}
else
{
	play_audio = 0;
	image_index = 0;
}