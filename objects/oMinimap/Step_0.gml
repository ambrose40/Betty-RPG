//Probably do this kind of thing from a dedicated mouse control system/object rather than here!
var _mx = mouse_x - camera_get_view_x(view_camera[0]);
var _my = mouse_y - camera_get_view_y(view_camera[0]);
if (mouse_check_button(mb_left)) 
{
	if (point_in_rectangle(_mx,_my,x,y,x+w,y+h))
	{
		with (oCamera)
		{
			x = (_mx - other.x) * TILE_SIZE;
			y = (_my - other.y) * TILE_SIZE;
			xTo = x;
			yTo = y;
			
		}
	}
}
		
		
		
		
		