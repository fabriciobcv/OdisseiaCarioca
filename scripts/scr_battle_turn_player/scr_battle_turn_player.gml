function scr_battle_turn_player() {
    // A lógica de ação só é executada quando o jogador está na fase de selecionar um alvo.
    if (oBattle.player_turn_state == "select_target") {
        // Se um item foi selecionado, aguarda o clique no alvo.
        if (oBattle.selected_item_index != -1) {
            if (mouse_check_button_pressed(mb_left)) {
                var item = global.inventory[| oBattle.selected_item_index];
                var target = (item.target == "ally") 
                    ? instance_position(mouse_x, mouse_y, obj_friend_parent) 
                    : instance_position(mouse_x, mouse_y, obj_enemy_parent);

                if (target != noone) {
                    use_item(oBattle.selected_item_index, target);
                    oBattle.item_used_this_turn = true;
                    oBattle.selected_item_index = -1;
                    oBattle.player_turn_state = "select_action"; // Retorna ao menu de ações
                }
            }
        }
        // Se um ataque foi selecionado, aguarda o clique no alvo.
        else if (oBattle.selected_attack_index != -1) {
            var attack = player.ataques[oBattle.selected_attack_index];
            if (player.stamina >= attack.cost) {
                if (mouse_check_button_pressed(mb_left)) {
                    var alvo = instance_position(mouse_x, mouse_y, obj_enemy_parent);
                    var alvoAliado = instance_position(mouse_x, mouse_y, obj_friend_parent);
                    
                    if (alvo != noone || alvoAliado != noone) {
                        if (alvo != noone && !attack.target_friends) {
                            acao_inimigo(alvo, attack, player.atk);
                        } else if (alvoAliado != noone && attack.target_friends) {
                            acao_aliado(alvoAliado, attack, player.atk);
                        } else {
                            return; // Clicou em um alvo inválido para a ação
                        }
                        
                        player.stamina -= attack.cost;
                        selected_attack_index = -1;
                        advance_turn(); // Passa o turno após o ataque
                    }
                }
            } else {
                // Se não tiver stamina, cancela a ação e volta ao menu
                selected_attack_index = -1;
                oBattle.player_turn_state = "select_action";
            }
        }
    }

    // Adicionado de volta: Garante que HP e Stamina não ultrapassem o máximo
    if (player.stamina > player.max_stamina) {
        player.stamina = player.max_stamina;	
    }
    
    if (player.hp > player.max_hp) {
        player.hp = player.max_hp;
    }
}

function acao_inimigo(alvo, attack, player_atk) {
    with (alvo) {
        hp -= calcular_dano(attack.power * player_atk, def);
        flash = true;
    }
}

function acao_aliado(alvo, attack, player_atk) {
	with (alvo) {
		hp += calcular_cura(attack.power * player_atk + player_atk);
	}
}