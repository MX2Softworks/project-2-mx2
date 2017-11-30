

if(place_meeting(x, y, obj_player)) 
{	
	collided = true;
}


if(collided){
	image_index = 1;
	
	if(play_audio == 0)
	{
		audio_play_sound_on(obj_soundeffect_emitter.switch_emitter, snd_switch, false, 1);
		play_audio = 1;
	}
	
	var i;
	for(i = 0; i < instance_number(obj_door); i++)
	{
		var door = instance_find(obj_door, i);
		
		if(door.col = obj_door_switch.col)
		{
			instance_deactivate_object(door.id);
			global.re_grid = true;
		}
	}
	collided = false;
}

else
{
	play_audio = 0;
	image_index = 0;
	pushed = 0;
}