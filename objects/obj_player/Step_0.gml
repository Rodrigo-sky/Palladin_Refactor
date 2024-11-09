/// @description Executes code every frame
// You can write your code in this editor

image_speed = 0;

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

x += horizontal_speed
if (horizontal_speed > max_horizontal_speed) {
	
	horizontal_speed = max_horizontal_speed;

} else if (horizontal_speed < -max_horizontal_speed) {
	
	horizontal_speed = -max_horizontal_speed;
}

