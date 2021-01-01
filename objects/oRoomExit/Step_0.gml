/// @desc Cause a room transition

if (instance_exists(oPlayer)) && (position_meeting(oPlayer.x,oPlayer.y,id))
{
	if (!instance_exists(oTransition)) && (oPlayer.state != PlayerStateDead)
	{
		
		// with (oPlayer) state = PlayerStateTransition;
		// RoomTransition(TRANS_TYPE.SLIDE, targetRoom)
		//with (oPlayer) state = PlayerStateTransition;
		global.targetRoom = targetRoom;
		global.targetDirectionPlayer = oPlayer.direction;
		global.targetXPlayer = targetX;
		global.targetYPlayer = targetY;
		room_goto(targetRoom);
		/*
		global.gamePaused = true;
		global.targetRoom = targetRoom;
		
		//global.targetDirectionPlayer = oPlayer.direction;
		with (oPlayer) state = PlayerStateTransition;
		RoomTransition(TRANS_TYPE.SLIDE, targetRoom)
		// instance_destroy();
		global.gamePaused = false;
		*/
	}
}