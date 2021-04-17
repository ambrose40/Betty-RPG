/// response
function DialogueResponses(response) {
	switch(response) {
		case 0: break;
		case 1: NewTextBox("Ahoy!", 1); break;
		case 2: NewTextBox("Eye! Eye!", 1); break;
		case 3: NewTextBox("I am grreat!", 1); break;
		case 4: NewTextBox("Therrre iz some fuzz around cave of death!", 1); break;
		case 5: NewTextBox("Nice to meet u too!", 1); break;
		case 6: NewTextBox("Yes I am the captain of this ship.\nWhat would you like to know?", 1, ["7:Is there any work on ship?"], "0:Have a great day, cap!"); break;
		case 7: NewTextBox("Not at the moment. \nCheck back later.", 1); break;
		case 8: {
			NewTextBox("Thanks!", 2);
			NewTextBox("I think I left the hat in\na tent on a beach further east!", 2);
			NewTextBox("Be careful it is occupied by\nBeholder demonic creature!", 2);
			global.questStatus[QUEST.THE_HAT_QUEST] = 1;
		}; break;
		case 9: {
			NewTextBox("Sad you see it that way!", 2);
		}; break;
		case 10: {
			NewTextBox("Bye!", 2);
		}; break;
		default: break;
	}
}
