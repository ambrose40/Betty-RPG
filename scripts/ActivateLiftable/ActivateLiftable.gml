/// @arg id
function ActivateLiftable(obj) {

	if (global.iLifted == noone) {
		PlayerActOutAnimation(sPlayerLift);
		
		spriteIdle = sPlayerCarry;
		spriteRun = sPlayerRunCarry;
		spriteRoll = sPlayerRunCarry;

		global.iLifted = obj;
		with (global.iLifted)
		{
			lifted = true;	
			persistent = true;
		}
	}
}
