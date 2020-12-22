/// @desc Progress Transition

with (oPlayer) {
	if (state != PlayerStateDead) state = PlayerStateTransition;
}

if (leading == OUT) {
	percent = min (1, percent + TRANSITION_SPEED)// + ((1 - percent)/25));
	// If screen fully obscured
	if (percent >= 1) {
		room_goto(target); 
		leading = IN;
	}
} else { // leading == IN
	percent = max (0, percent - 0.02) // - (percent/25));
	if (percent <= 0) { // If screen fully revealed
		with (oPlayer) state = PlayerStateFree;
		PlayMainMusic();
		instance_destroy();
	}
}