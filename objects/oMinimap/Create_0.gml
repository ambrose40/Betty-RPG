// Keep the map proportional to the GUI while preserving the room's aspect ratio.
depth = 10000; // Draw before the HUD, dialogue and transition overlays.
surfMinimapBg = -1;
w = 0;
h = 0;

function UpdateMinimapLayout() {
	var _guiWidth = display_get_gui_width();
	var _guiHeight = display_get_gui_height();
	var _maxWidth = max(1, floor(_guiWidth / 4));
	var _maxHeight = max(1, floor(_guiHeight / 3));
	var _scale = min(_maxWidth / room_width, _maxHeight / room_height);
	var _width = max(1, floor(room_width * _scale));
	var _height = max(1, floor(room_height * _scale));
	if (w != _width || h != _height) {
		if (surface_exists(surfMinimapBg)) surface_free(surfMinimapBg);
		surfMinimapBg = -1;
		w = _width;
		h = _height;
	}
	x = _guiWidth - w - 10;
	y = 10;
}

// Camera coverage expressed in map pixels, clipped to the room's available area.
function GetMinimapViewport() {
	var _cam = view_camera[0];
	if (_cam == -1) return undefined;
	var _left = clamp(camera_get_view_x(_cam), 0, room_width);
	var _top = clamp(camera_get_view_y(_cam), 0, room_height);
	var _right = clamp(camera_get_view_x(_cam) + camera_get_view_width(_cam), _left, room_width);
	var _bottom = clamp(camera_get_view_y(_cam) + camera_get_view_height(_cam), _top, room_height);
	return {
		x: _left * w / room_width,
		y: _top * h / room_height,
		width: (_right - _left) * w / room_width,
		height: (_bottom - _top) * h / room_height
	};
}

UpdateMinimapLayout();

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
