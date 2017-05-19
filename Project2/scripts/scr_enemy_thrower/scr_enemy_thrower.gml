// Check to see if the player exists
if(instance_exists(obj_player))
{
    if(timer >= 120)
    {
        if(!soundplayed)
        {
            audio_emitter_gain(audio_em, .25);
            audio_play_sound_on(audio_em, snd_fireball, false, 5);
            soundplayed = 1;
        }
        
        if(duration < 60)
        {
            // Fire projectiles
            instance_create(x - 16, y - 16, obj_fireball);
            duration += 1;
        }
        else
        {
            duration = 0;
            timer = 0;
            soundplayed = 0;
        }
    }
    else
    {
        timer += 1; // Increment the timer by 1
    }
}
