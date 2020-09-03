/// @desc Transition(type, mode, targetroom)
/// @arg Type sets transition type, slide/fade etc.
/// @arg Target sets target room when using the goto mode.
function RoomTransition() {

	if (!instance_exists(oTransition))
	{
		with (instance_create_depth(x,y,-9999,oTransition))	
		{
			type = argument[0];
			target = argument[1];
		}
	} else show_debug_message("Trying to transition while transition is happening!");


}
