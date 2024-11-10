/// @description Executes code every frame
// You can write your code in this editor

image_speed = 1;

var _key_right = keyboard_check(vk_right);
var _key_left = keyboard_check(vk_left);
var _key_jump = keyboard_check_pressed(vk_up);
var _key_atack = keyboard_check(vk_space);
var _key_fall = keyboard_check_released(vk_up);
var _key_run = keyboard_check(vk_shift);
var _hero_right = keyboard_check_released(vk_right);
var _hero_left = keyboard_check_released(vk_left);

if (_key_right) {
	horizontal_speed ++;
	
}

if (_key_left) {
	horizontal_speed --;
}

if ((!_key_right) && (!_key_left)) {
	horizontal_speed = 0;
}


if (horizontal_speed > max_horizontal_speed) {
	
	horizontal_speed = max_horizontal_speed;

} else if (horizontal_speed < -max_horizontal_speed) {
	
	horizontal_speed = -max_horizontal_speed;
}

if (place_meeting(x+horizontal_speed,y, obj_solid_block)) {
	
	horizontal_speed = 0;
	
} else {
	x += horizontal_speed
}

//###########################################################################################

if (place_meeting(x, y+1, obj_solid_block)) { 
	ground = true 
} else { 
	ground = false 
}

if (!_key_jump && !ground) {
	vertical_speed ++;
} else {
	vertical_speed = 0;
}

if (_key_jump && ground) {
	vertical_speed = jump_speed;
}


if ((place_meeting(x, y+vertical_speed, obj_solid_block))){
	while (!place_meeting(x, y+1, obj_solid_block)) {
		y += 1;
	}
	ground = true;
	vertical_speed = 0
}

y += vertical_speed;