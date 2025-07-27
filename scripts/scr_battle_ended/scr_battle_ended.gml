function scr_battle_ended() {
	
	array_foreach(inimigos, function(inimigo, index) {
		instance_destroy(inimigo);
	})
	
	battle_active = false;
	
	show_debug_message("A batalha terminou");
}