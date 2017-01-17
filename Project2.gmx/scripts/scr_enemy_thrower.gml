// Check to see if the player exists
if(instance_exists(obj_player))
{
    if(timer >= 120)
    {
        // Fire projectiles
        instance_create(x - 16, y - 16, obj_fireball);
        timer = 0;
    }
    else
    {
        timer += 1; // Increment the timer by 1
    }
}
