function scr_battle_player_won() {
    show_message("Vitória!");
	
	reset_player_bars(player);
	
	xp_droped = 0;
	
	array_foreach(inimigos, function(inimigo, index) {
		xp_droped += inimigo.xp_drop;
	})
	
	player.xp += xp_droped;
	
	player.can_move = true;
	
	end_battle();
}