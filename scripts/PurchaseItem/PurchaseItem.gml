function PurchaseItem(_item, _amount, _cost) {
	if (global.coinsAmount >= _cost) {
		global.playerHasAnyItems = true;
		global.playerItemUnlocked[_item] = true;
		global.playerAmmo[_item] += _amount;
		global.coinsAmount -= _cost
		global.playerEquipped = _item;
		instance_destroy(activate);
		
		var _desc = "";
		switch (_item) {
			case ITEM.BOW: _desc = "The bow!\n Fire with activate key to damage enemies on distance,\nfind ammo in the world!"; break;
			case ITEM.BOMB: _desc = "Bombs!\n Activate to light the fuse then action key to throw!\nBlow apart enemies, pots\nand large cave blocking boulders!"; break;
			case ITEM.HOOK: _desc = "The grappling hook!\nActivate to grab things toward you,\nor you towards things!\nUse with care."; break;
			default: _desc = "No item description found!"; break;
		}
		NewTextBox(_desc, 1);
	} else {
		NewTextBox("Not enough money...", 1);
	}

}