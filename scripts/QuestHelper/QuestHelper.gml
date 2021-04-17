// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ActivateHatCat() {
	var _hasHat = (global.iLifted != noone) && (global.iLifted.object_index == oHat);
	switch (global.questStatus[QUEST.THE_HAT_QUEST]) {
		case 0: // Not started
			// Player might have brought the hat back anyway
			if (_hasHat) {
				// complete quest
				NewTextBox("Wow! You've found my hat even\nwithout me even asking you to!", 2);
				CompleteHatCat();
				
			} else {
				// offer a quest
				NewTextBox("Hello there!\nYou look like a brave adventurer!", 2);
				NewTextBox("Could you help me find me my missing cap?",2, ["8:Of course!", "9:This task is beneath me", "10:Goodbye"]);
			}
		break;
		case 1: // Quest is in progress
			if (_hasHat) {
				// complete quest
				NewTextBox("Wow, you've found my hat!", 2);
				CompleteHatCat();
			} else {
				// clue reminder
				NewTextBox("I think I left the hat in\na tent on a beach further east!", 2);
				NewTextBox("You might need special sword\nto defeat the demon there!", 2);
			} 
		break;
		case 2: // Quest already completed
			NewTextBox("Thanks again!", 2);
		break;
	}
}

function CompleteHatCat() {
	NewTextBox("You are true hero indeed!", 2);
	global.questStatus[QUEST.THE_HAT_QUEST] = 2;
	with (oNPC) sprite_index = sQuestieHat;
	with (oHat) instance_destroy();
		
	DropItem();
}