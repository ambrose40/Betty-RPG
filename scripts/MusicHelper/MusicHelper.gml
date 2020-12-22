// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function PlayDeathMusic(){
	if audio_is_playing(mBattle) {
		audio_stop_sound(mBattle);
	}
	if audio_is_playing(mMain) {
		audio_stop_sound(mMain);
	}
	if audio_is_playing(mTrader) {
		audio_stop_sound(mTrader);
	}
	if !audio_is_playing(mMenu1) {
		audio_play_sound(mMenu1, 1000, true);
	}
}

function PlayMainMusic(){
	if audio_is_playing(mBattle) {
		audio_stop_sound(mBattle);
	}
	if audio_is_playing(mMenu1) {
		audio_stop_sound(mMenu1);
	}
	if audio_is_playing(mTrader) {
		audio_stop_sound(mTrader);
	}
	if !audio_is_playing(mMain) {
		audio_play_sound(mMain, 1000, true);
	}
}

function PlayBattleMusic(){
	if audio_is_playing(mMain) {
		audio_stop_sound(mMain);
	}
	if audio_is_playing(mMenu1) {
		audio_stop_sound(mMenu1);
	}
	if audio_is_playing(mTrader) {
		audio_stop_sound(mTrader);
	}
	if !audio_is_playing(mBattle) {
		audio_play_sound(mBattle, 1000, true);
	}
}

function PlayLockedMusic(){
	if audio_is_playing(mMain) {
		audio_stop_sound(mMain);
	}
	if audio_is_playing(mMenu1) {
		audio_stop_sound(mMenu1);
	}
	if audio_is_playing(mBattle) {
		audio_stop_sound(mBattle);
	}
	if !audio_is_playing(mTrader) {
		audio_play_sound(mTrader, 1000, true);
	}
}