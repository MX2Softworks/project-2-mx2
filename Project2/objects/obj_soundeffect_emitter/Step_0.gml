/// @description Insert description here

audio_emitter_position(player_emitter, obj_player.x, obj_player.y, 0);

/// the simple beginner one :
if((obj_player.sprite_index == spr_player_jump) && played == 0)
{
	var n = irandom(4);
	if n==0 audio_play_sound(snd_jump0,0,false);
	if n==1 audio_play_sound(snd_jump1,0,false);
	if n==2 audio_play_sound(snd_jump2,0,false);
	if n==3 audio_play_sound(snd_jump3,0,false);
	if n==4 audio_play_sound(snd_jump4,0,false);
	
	played = 1;
}

if(obj_player.on_ground)
{
	played = 0;	
}
