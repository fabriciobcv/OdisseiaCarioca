function scr_battle_player_won() {
    show_message("Vitória!");
    instance_destroy();
	
	reset_player_bars();
}