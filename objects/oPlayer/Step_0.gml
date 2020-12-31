//Get Player Input
keyLeft = keyboard_check(vk_left);
keyRight = keyboard_check(vk_right); 
keyUp = keyboard_check(vk_up); 
keyDown = keyboard_check(vk_down); 
keyActivate = keyboard_check_pressed(vk_space);
keyAttack = keyboard_check_pressed(vk_control);
keyItem = keyboard_check_pressed(vk_shift);
keyFullScreen = keyboard_check_pressed(vk_enter);
keyExit = keyboard_check_pressed(vk_escape);
keyDefend = keyboard_check(vk_end);
keyRest = keyboard_check(vk_home);
inputDirection = point_direction(0,0,keyRight-keyLeft,keyDown-keyUp);
inputMagnitude = (keyRight - keyLeft != 0) || (keyDown - keyUp != 0);

if (keyFullScreen) {
	window_set_fullscreen(!window_get_fullscreen());
}
if (keyExit) {
	game_end();
}
if (!global.gamePaused) {
	script_execute(state);
	invulnerable = max(invulnerable-1,0);
	flash = max(flash-0.05,0);
}
audio_listener_position(x, y, z);
depth = -bbox_bottom;