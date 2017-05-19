// Spawns random fireballs in the level

timer += 1;

if((timer mod 15) == 0)
{
    count += 1;
    
    if((count mod freq) == 0)
    {
        randx = random_range(32, 992);
        
        instance_create(randx, 1074, obj_random_fireball);
    }
}

// increase the interval from 5-10 seconds
if (count >= 20 && count < 40)
{
    freq = 8;
}

// increase the interval from 5-10 seconds
if (count >= 40 && count < 60)
{
    freq = 4;
}

// increase the interval from 5-10 seconds
if (count >= 60 && count < 80)
{
    freq = 2;
}

// increase the interval from 5-10 seconds
if (count >= 80 && count < 100)
{
    freq = 1;
}

// increase the interval from 5-10 seconds
if (count > 100)
{
    freq = 1;
}
