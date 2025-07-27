function scr_battle_player_won() {
    show_message("Vitória!");
	
	reset_player_bars(player);
	
	var xp_droped = 0;
	
	// Usando um loop for padrão para evitar problemas de escopo
	for (var i = 0; i < array_length(inimigos); i++) {
		var inimigo = inimigos[i];
		xp_droped += inimigo.xp_drop;
		
		// A lógica de drop continua funcionando como antes
		get_drops(inimigo);
	}
	
	player.xp += xp_droped;
	player.can_move = true;
	
	end_battle();
}