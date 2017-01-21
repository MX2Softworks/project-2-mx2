// Spawns random fireballs in the level

timer += 1;

if((timer mod 60) == 0)
{
    count += 1;
    
    if((count mod 2) == 0)
    {
        randx = random_range(0, 1024);
        
        instance_create(randx, 1074, obj_random_fireball);
    }
}

// every 5 seconds, increase the frequency of the fireballs
if((count mod 5) == 0)
{
    freq *= 0.5;
}
