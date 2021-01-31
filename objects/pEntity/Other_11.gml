/// @desc Drop fragments & items

// Drop fragments
if (visible) {
	if (entityFragmentCount > 0) {
		fragmentArray = array_create(entityFragmentCount, entityFragment);	
		DropItems(x, y, fragmentArray);
	}

	// Drop collectibles
	if (entityDropList != -1) {
		DropItems(x, y, entityDropList);
	}
	visible = false;
}