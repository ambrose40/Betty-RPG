if (state == PlayerStateDead)
{	
	oPlayer.coinsAmount = 0;
	
	global.playerHealth = global.playerHealthMax;
	global.playerEnergy = global.playerEnergyMax;
	global.lastEnemyHurt = "";
	global.deathReason = "Permadeath!";
}