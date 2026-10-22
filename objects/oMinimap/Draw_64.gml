UpdateMinimapLayout();
if (!surface_exists(surfMinimapBg)) {
	if (!RefreshMapBG()) exit;
}
var _colour = draw_get_colour();
var _alpha = draw_get_alpha();
draw_set_colour(c_white);
draw_set_alpha(1);
draw_surface(surfMinimapBg, x, y);

// Scale both the viewport and live markers to this room, including small interiors.
var _scaleX = w / room_width;
var _scaleY = h / room_height;
var _view = GetMinimapViewport();
if (!is_undefined(_view) && _view.width > 0 && _view.height > 0) {
	draw_rectangle(x + _view.x, y + _view.y,
		x + _view.x + max(0, _view.width - 1),
		y + _view.y + max(0, _view.height - 1), true);
}

var _mapX = x;
var _mapY = y;
var _mapW = w;
var _mapH = h;
draw_set_colour(c_red);
with (pEntity) {
	if (visible && entityOnMinimap) {
		var _px = _mapX + clamp(floor(x * _scaleX), 0, _mapW - 1);
		var _py = _mapY + clamp(floor(y * _scaleY), 0, _mapH - 1);
		draw_point(_px, _py);
	}
}
draw_set_colour(c_lime);
with (oPlayer) {
	var _px = _mapX + clamp(floor(x * _scaleX), 0, max(0, _mapW - 2));
	var _py = _mapY + clamp(floor(y * _scaleY), 0, max(0, _mapH - 2));
	draw_rectangle(_px, _py, _px + 1, _py + 1, false);
}
draw_sprite_stretched(sMinimapBox, 0, x - 6, y - 6, w + 12, h + 12);
draw_set_colour(_colour);
draw_set_alpha(_alpha);
