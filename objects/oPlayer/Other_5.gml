if (state == PlayerStateDead)
{	
	global.coinsAmount = 0;
	
	global.playerHealth = global.playerHealthMax;
	global.playerEnergy = global.playerEnergyMax;
	global.lastEnemyHurt = "";
	global.deathReason = "Permadeath!";
}