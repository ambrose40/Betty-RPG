/// @description Record GIF

if (keyboard_check_pressed(ord("G"))) {
	gifRecord = !gifRecord;
	
	if (gifRecord) {
		gif = gif_open(RESOLUTION_W, RESOLUTION_H);
	} else {
		str = string(current_year) + "." + string(current_month) + "." + string(current_day) + "." + string(current_hour) + "." + string(current_minute) + "." + string(current_second);
		filename = "Betty RPG - Capture - " + str + ".gif";
		show_debug_message("Saved recording (GIF) to file: " + filename);
		gif_save(gif, filename);
		//Betty RPG - Capture - " + str + "
	}
}

if (gifRecord) {
	gif_add_surface(gif, application_surface, 2);
}