// The minimap is in GUI coordinates, independent of the world camera/fullscreen.
x = display_get_gui_width() - w - 10;
if (global.gamePaused) exit;
var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);
if (mouse_check_button(mb_left) && point_in_rectangle(_mx, _my, x, y, x + w, y + h)) {
	var _worldX = (_mx - x) * room_width / w;
	var _worldY = (_my - y) * room_height / h;
	with (oCamera) {
		x = _worldX;
		y = _worldY;
		xTo = x;
		yTo = y;
	}
}
