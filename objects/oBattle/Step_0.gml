// Verificar fim da batalha
if (!setup_done) {
    setup_done = true;
    inicializar_batalha(id);
	
	if (!instance_exists(oBattleUI)) {
		instance_create_layer(0, 0, 0, oBattleUI);
	}
}

if (!battle_active) {
	exit;
}

if (array_length(inimigos) == 0 || all_dead(inimigos)) {
    battle_state = "player_won";
}

if (battle_is_player_dead(player)) {
	battle_state = "player_lost";
}

// Controle do estado da batalha
switch (battle_state) {
	case "start":
	    current_turn = 0;
	    var ent = turn_queue[current_turn];
	    if (ent == player) {
	        battle_state = "turn_player";
	    } else {
	        battle_state = "turn_enemy";
	    }
	    break;

	case "turn_player":
	    // Se um ataque foi selecionado (pelo clique na UI), aguarda a seleção do alvo
	    if (selected_attack_index != -1) {
	        if (mouse_check_button_pressed(mb_left)) {
	            var alvo = instance_position(mouse_x, mouse_y, obj_enemy_parent);
	            if (alvo != noone) {
	                var attack = player.ataques[selected_attack_index];
	                with (alvo) {
	                    hp -= calcular_dano(attack.power, alvo.def);
						flash = true; // <-- Adicione esta linha
	                }
	                selected_attack_index = -1; // Reseta a seleção para o próximo turno
	                advance_turn();
	            }
	        }
	    }
	    // A lógica de clique para selecionar o ataque está no oBattleUI (Draw GUI Event).
	    break;

	case "turn_enemy":
	    var ent = turn_queue[current_turn];
	    if (instance_exists(ent)) {
	        with (ent) {
	            if (instance_exists(other.player)) {
	                other.player.hp -= calcular_dano(ent.atk, other.player.def);
					other.player.flash = true;
	            }
	        }
	    }
	    advance_turn();
	    break;

	case "player_won":
	    show_message("Vitória!");
	    instance_destroy();
	    break;

	case "player_lost":
	    show_message("Derrota.");
	    room_goto(GameOver);
	    instance_destroy();
	    break;
}