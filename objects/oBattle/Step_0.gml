// file: objects/oBattle/Step_0.gml

if (!battle_active) {
	show_debug_message("Vai destruir oBattle");
    instance_destroy();
}

if (!setup_done) {
    setup_done = true;
    inicializar_batalha(id);
    
    if (!instance_exists(oBattleUI)) {
		layer_create(-9999, "layer_ui")
        instance_create_layer(0, 0, "layer_ui", oBattleUI);
    }
}

if(!(battle_state == "ended")) {
	if (array_length(inimigos) == 0 || all_dead(inimigos)) {
	    battle_state = "player_won";
	}

	if (battle_is_player_dead(player)) {
	    battle_state = "player_lost";
	}
}

var battle = self

var state_script = asset_get_index("scr_battle_" + battle_state);

if (state_script != -1) {
    script_execute(state_script);
}