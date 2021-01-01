/// @description Save screenshot

str = string(current_year) + "." + string(current_month) + "." + string(current_day) + "." + string(current_hour) + "." + string(current_minute) + "." + string(current_second);
filename = "Betty RPG - Screenshot - " + str + ".png";
show_debug_message("Saved screenshot (PNG) to file: " + filename);
screen_save(filename);