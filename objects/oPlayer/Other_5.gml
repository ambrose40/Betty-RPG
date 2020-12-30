if (state == PlayerStateDead)
{	
	global.playerHealth = global.playerHealthMax;
	global.playerEnergy = global.playerEnergyMax;
	global.lastEnemyHurt = "";
	global.deathReason = "Permadeath!";
}