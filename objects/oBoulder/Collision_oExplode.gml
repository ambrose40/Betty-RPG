/// @description Destroy boulder by bomb explosion

fragmentArray = array_create(40 + irandom(30), oFragRock);	
DropItems(x, y, fragmentArray);
	
fragmentArray = array_create(40 + irandom(30), oFragRock2);	
DropItems(x, y, fragmentArray);

instance_destroy();