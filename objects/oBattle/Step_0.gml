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


if(battle_is_player_dead(player)) {
	battle_state = "player_lost";	
}

// Controle do estado da batalha
switch (battle_state) {
	case "start":
	    // Exibe mensagem opcional
	    //show_message("A batalha começou!");
		current_turn = 0;
	    var ent = turn_queue[current_turn];

	    if (ent == player) {
	        battle_state = "turn_player";
		} else {
			        battle_state = "turn_enemy";
		}
		break;

	case "turn_player":
	    // Lógica para seleção de ataque
	    var num_attacks = array_length(player.ataques);
	    if (keyboard_check_pressed(vk_up)) {
	        selected_attack_index = (selected_attack_index - 1 + num_attacks) % num_attacks;
	    }
	    if (keyboard_check_pressed(vk_down)) {
	        selected_attack_index = (selected_attack_index + 1) % num_attacks;
	    }

	    if (keyboard_check_pressed(vk_enter)) {
	        selecting_target = true;
	        battle_state = "player_select_target";
	    }
	    break;

	case "player_select_target":
	    // Espera o jogador selecionar um alvo
	    if (mouse_check_button_pressed(mb_left)) {
	        var alvo = instance_position(mouse_x, mouse_y, obj_enemy_parent);
	        if (alvo != noone) {
	            var attack = player.ataques[selected_attack_index];
	            with (alvo) {
	                hp -= attack.power;
	                if (hp <= 0) instance_destroy();
	            }
	            selecting_target = false;
	            advance_turn();
	        }
	    }
	    break;

	case "turn_enemy":
		var ent = turn_queue[current_turn];
		if (instance_exists(ent)) {
		        with (ent) {
		            if (instance_exists(other.player)) {
		                other.player.hp -= 5;
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
		room_goto(GameOver)
		instance_destroy();
		break;
}