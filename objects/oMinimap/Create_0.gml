// Keep the map compact while preserving the room's aspect ratio.
depth = 10000; // Draw before the HUD, dialogue and transition overlays.
surfMinimapBg = -1;
var _scale = min(1 / TILE_SIZE, 80 / room_width, 60 / room_height);
w = max(1, floor(room_width * _scale));
h = max(1, floor(room_height * _scale));
x = display_get_gui_width() - w - 10;
y = 10;

// Build the background lazily in Draw GUI, when surfaces can be rendered safely.
function RefreshMapBG() {
	if (surface_exists(surfMinimapBg)) surface_free(surfMinimapBg);
	surfMinimapBg = surface_create(w, h);
	var _surfTemp = surface_create(room_width, room_height);
	if (!surface_exists(surfMinimapBg) || !surface_exists(_surfTemp)) {
		if (surface_exists(_surfTemp)) surface_free(_surfTemp);
		if (surface_exists(surfMinimapBg)) surface_free(surfMinimapBg);
		surfMinimapBg = -1;
		return false;
	}

	var _colour = draw_get_colour();
	var _alpha = draw_get_alpha();
	draw_set_colour(c_white);
	draw_set_alpha(1);
	var _layers = layer_get_all();
	array_sort(_layers, function(_a, _b) {
		return layer_get_depth(_b) - layer_get_depth(_a);
	});
	surface_set_target(_surfTemp);
	draw_clear(c_black);
	for (var _i = 0; _i < array_length(_layers); _i++) {
		var _layer = _layers[_i];
		if (!layer_get_visible(_layer) || layer_get_name(_layer) == "Col") continue;
		var _elements = layer_get_all_elements(_layer);
		for (var _j = 0; _j < array_length(_elements); _j++) {
			var _element = _elements[_j];
			var _type = layer_get_element_type(_element);
			if (_type == layerelementtype_tilemap) {
				draw_tilemap(_element, layer_get_x(_layer) + tilemap_get_x(_element),
					layer_get_y(_layer) + tilemap_get_y(_element));
			} else if (_type == layerelementtype_background) {
				if (!layer_background_get_visible(_element)) continue;
				var _sprite = layer_background_get_sprite(_element);
				var _blend = layer_background_get_blend(_element);
				var _opacity = layer_background_get_alpha(_element);
				if (_sprite == -1) {
					draw_set_colour(_blend);
					draw_set_alpha(_opacity);
					draw_rectangle(0, 0, room_width, room_height, false);
					draw_set_colour(c_white);
					draw_set_alpha(1);
				} else if (layer_background_get_stretch(_element)) {
					draw_sprite_stretched_ext(_sprite, 0, layer_get_x(_layer), layer_get_y(_layer),
						room_width, room_height, _blend, _opacity);
				} else {
					var _sx = layer_background_get_xscale(_element);
					var _sy = layer_background_get_yscale(_element);
					draw_sprite_ext(_sprite, 0,
						layer_get_x(_layer) + sprite_get_xoffset(_sprite) * _sx,
						layer_get_y(_layer) + sprite_get_yoffset(_sprite) * _sy,
						_sx, _sy, 0, _blend, _opacity);
				}
			}
		}
	}
	surface_reset_target();
	surface_set_target(surfMinimapBg);
	draw_clear(c_black);
	draw_surface_stretched(_surfTemp, 0, 0, w, h);
	surface_reset_target();
	surface_free(_surfTemp);
	draw_set_colour(_colour);
	draw_set_alpha(_alpha);
	return true;
}
