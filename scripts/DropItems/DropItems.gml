/// @desc DropItems(x, y, [items])
/// @arg x
/// @arg y
/// @arg [items] array of items to drop
function DropItems(argument0, argument1, argument2) {
	var _items = array_length_1d(argument2);
	/*
	if (_items >= 1) {
		var _count = 10;
		if (_items < 10) {
			_count = _items;
		}
		var _anglePerItem = 360/_count;
		var _angle = random(360);
		for (var i = 0; i < _count; i++) {
			with (instance_create_layer(argument0,argument1,"Instances",argument2[i])) {
				direction = _angle;
				spd = 0.75 + (_count * 0.1) + random(0.1);
			}
			_angle += _anglePerItem;
		}
	}
	if (_items >= 10) {
		var _countS = 10;
		var _countE = 30;
		if (_items < 30) {
			_countE = _items;
		}
		var _anglePerItem = 360/(_countE-_countS);
		var _angle = random(360);
		for (var i = _countS; i < _countE; i++) {
			with (instance_create_layer(argument0,argument1,"Instances",argument2[i])) {
				direction = _angle;
				spd = 0.75 + (15 * 0.1) + random(0.1);
			}
			_angle += _anglePerItem;
		}
	}
	*/
	if (_items >= 1) {
		var _countS = 0;
		var _countE = _items;
		var _anglePerItem = 360 / (_countE - _countS);
		var _angle = random(360);
		for (var i = _countS; i < _countE; i++) {
			with (instance_create_layer(argument0, argument1, "Instances", argument2[i])) {
				direction = _angle;
				spd = 0.75 + (random(30) * 0.1) + random((_items / 30) * 0.2);
			}
			_angle += _anglePerItem;
		}
	} 
	
	if (_items <= 0) {
		instance_create_layer(argument0,argument1,"Instances",argument2[0]);
	}
}
