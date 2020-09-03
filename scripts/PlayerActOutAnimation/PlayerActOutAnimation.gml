/// @desc PlayerActOutAnimation(sprite, end script)
/// @arg sprite
/// @arg end_script 
function PlayerActOutAnimation() {

	//Carry out an animation and optionally carry out a script when the animation ends

	state = PlayerStateAct;
	sprite_index = argument[0];
	if (argument_count > 1) animationEndScript = argument[1];
	localFrame = 0;
	image_index = 0;
	PlayerAnimateSprite();
}
