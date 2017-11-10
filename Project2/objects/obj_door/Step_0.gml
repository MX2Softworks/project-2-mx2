/// @description Insert description here

if((obj_door_switch.col == obj_door.col) && obj_door_switch.pushed == 1)
{
	instance_deactivate_object(obj_door);
}
