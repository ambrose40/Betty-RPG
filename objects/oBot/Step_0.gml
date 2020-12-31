//Get Player Input
/*
keyLeft = keyboard_check(ord("A"));
keyRight = keyboard_check(ord("D")); 
keyUp = keyboard_check(ord("W")); 
keyDown = keyboard_check(ord("S")); 
*/
keyLeft = keyboard_check(ord("A"));
keyRight = keyboard_check(ord("D")); 
keyUp = keyboard_check(ord("W")); 
keyDown = keyboard_check(ord("S")); 

keyActivate = false;
keyAttack = false;
keyItem = false;
keyFullScreen = false;
keyExit = false;
keyDefend = false;
keyRest = false;

inputDirection = point_direction(0,0,keyRight-keyLeft,keyDown-keyUp);
inputMagnitude = (keyRight - keyLeft != 0) || (keyDown - keyUp != 0);

if (!global.gamePaused) {
	script_execute(state);
	invulnerable = max(invulnerable-1,0);
	flash = max(flash-0.05,0);
}
depth = -bbox_bottom;