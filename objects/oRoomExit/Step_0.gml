/// @desc Cause a room transition
if (instance_exists(oPlayer)) && (position_meeting(oPlayer.x, oPlayer.y ,id)) {
	if (!instance_exists(oTransition)) && (oPlayer.state != PlayerStateDead) {		
		global.targetRoom = targetRoom;
		global.targetDirectionPlayer = oPlayer.direction;
		global.targetXPlayer = targetX;
		global.targetYPlayer = targetY;
		global.saveXPlayer = returnX;
		global.saveYPlayer = returnY;
		global.saveDirectionPlayer = returnDirection;
		//room_goto(targetRoom);
		
		with (oPlayer) state = PlayerStateTransition;
		RoomTransition(TRANS_TYPE.SLIDE, targetRoom);
	}
}