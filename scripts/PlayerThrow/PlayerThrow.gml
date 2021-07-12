function PlayerThrow() {
	with (global.iLifted) {
		lifted = false;
		persistent = false;
		z = 13;
		throwPeakHeight = z + 10;
		throwDistance = entityThrowDistance;
		throwDistanceTravelled = 0;
		throwStartPercent = (13 / throwPeakHeight) * 0.5;
		throwPercent = throwStartPercent;
		direction = other.direction;
		x += lengthdir_x(5, direction);
		y += lengthdir_y(5, direction);
		xstart = x;
		ystart = y;
		thrown = true;
	}
	
	PlayerActOutAnimation(sPlayerLift);
	
	DropItem();
}

function DropItem() {
	with (global.iLifted) {
		lifted = false;
	}
	global.iLifted = noone;
	with (oPlayer) {
		spriteIdle = sPlayer;
		spriteRun = sPlayerRun;
		spriteRoll = sPlayerRoll;
	}
}
