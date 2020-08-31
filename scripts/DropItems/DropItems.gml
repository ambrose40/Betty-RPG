/// @desc DropItems(x, y, [items])
/// @arg x
/// @arg y
/// @arg [items] array of items to drop
function DropItems(argument0, argument1, argument2) {

	var _items = array_length_1d(argument2);

	if (_items > 1)
	{
		var _anglePerItem = 360/_items;
		var _angle = random(360);
		for (var i = 0; i < _items; i++)
		{
			with (instance_create_layer(argument0,argument1,"Instances",argument2[i]))
			{
				direction = _angle;
				spd = 0.75 + (_items * 0.1) + random(0.1);
			}
			_angle += _anglePerItem;
		}
	
	
	}else instance_create_layer(argument0,argument1,"Instances",argument2[0]);


}
