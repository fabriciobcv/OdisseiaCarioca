function parar_player() {
	obj_player.can_move = false;
	obj_player.sprite_index = spr_player_idle
}

function destravar_player() {
	obj_player.can_move = true;
}
