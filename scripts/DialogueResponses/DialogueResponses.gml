/// @arg Response
function DialogueResponses(argument0) {
	switch(argument0) {
		case 0: break;
		case 1: NewTextBox("Ahoy!", 1); break;
		case 2: NewTextBox("Eye! Eye!", 1); break;
		case 3: NewTextBox("I am grreat!", 1); break;
		case 4: NewTextBox("Therrre iz some fuzz around cave of death!", 1); break;
		case 5: NewTextBox("Nice to meet u too!", 1); break;
		case 6: NewTextBox("Yes I am the captain of this ship.\nWhat would you like to know?", 1, ["7:Is there any work on ship?"], "0:Have a great day, cap!"); break;
		case 7: NewTextBox("Not at the moment. \nCheck back later.", 1); break;
		default: break;
	}
}
