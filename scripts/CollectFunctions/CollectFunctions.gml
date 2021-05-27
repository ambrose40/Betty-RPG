// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function CollectCoins(_amount) {
	global.coinsAmount += _amount;
}

function CollectAmmo(_array) {
	//array = [type, amount]
	global.playerHasAnyItems = true;
	global.playerItemUnlocked[_array[0]] = true;
	global.playerAmmo[_array[0]]+=_array[1];
}