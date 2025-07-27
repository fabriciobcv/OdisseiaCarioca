function scr_battle_turn_player() {
    // Lógica de uso de item - Executa apenas quando um item válido é selecionado
    if (oBattle.selected_item_index >= 0) {
        if (mouse_check_button_pressed(mb_left)) {
            var item = global.inventory[| oBattle.selected_item_index];
            var target = noone;

            if (item.target == "ally") {
                target = instance_position(mouse_x, mouse_y, obj_friend_parent);
            } else { // "enemy"
                target = instance_position(mouse_x, mouse_y, obj_enemy_parent);
            }

            if (target != noone) {
                use_item(oBattle.selected_item_index, target);
                oBattle.item_used_this_turn = true;
                oBattle.selected_item_index = -1; // Reseta a seleção de item
            }
        }
        return; // Aguarda a seleção do alvo para o item
    }

    // Lógica de ataque (só executa se um item não estiver selecionado para uso)
    if (oBattle.selected_attack_index != -1) {
        var attack = player.ataques[selected_attack_index];
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
                        return;
                    }
					
					player.stamina -= attack.cost;
					selected_attack_index = -1;
					advance_turn();
				}
            }
        } else {
            selected_attack_index = -1;
        }
    }
	
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
		hp += calcular_cura(attack.power * player_atk + player_atk)	
	}
}