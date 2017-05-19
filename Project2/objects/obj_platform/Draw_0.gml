/// @description Tile sprite across surface

s_width = sprite_get_width(spr_platform);   //Width of the sprite in pixels.
s_height = sprite_get_height(spr_platform); //Height of the sprite in pixels. 

offset_x =  s_width * image_xscale/2 - s_width/2;   //Offset is in pixels from origin of object, subtract width/2 to compensate for drawing from origin.
offset_y =  s_height * image_yscale/2 - s_height/2; //Offset is in pixels from origin of object, subtract height/2 to compensate for drawing from origin. 

//tiles sprites across the width and height of the object. Only works for scales of whole numbers. 
for(index_x = 0; index_x < image_xscale * s_width; index_x += s_width){
    for(index_y = 0; index_y < image_yscale * s_height; index_y += s_height){
        draw_sprite(spr_platform, 0, x-offset_x+index_x, y-offset_y+index_y); 
    }
}


