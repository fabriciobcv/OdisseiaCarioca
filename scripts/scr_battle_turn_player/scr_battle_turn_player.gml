function scr_battle_turn_player() {
    if (selected_attack_index != -1) {
        var attack = player.ataques[selected_attack_index];
        
        // Verifica se há stamina suficiente
        if (player.stamina >= attack.cost) {
            if (mouse_check_button_pressed(mb_left)) {
                var alvo = instance_position(mouse_x, mouse_y, obj_enemy_parent);
				var alvoAliado = instance_position(mouse_x, mouse_y, obj_friend_parent);
				
				if(alvo != noone || alvoAliado != noone) {
					if(alvo != noone) {
						acao_inimigo(alvo, attack, player.atk)

					} else if(attack.target_friends) {
						acao_aliado(alvoAliado, attack, player.atk)
					}
					
					player.stamina -= attack.cost;
					selected_attack_index = -1;
					advance_turn();
				}
            }
        } else {
            // Se não tiver stamina, impede o ataque
            // (Opcional: mostrar uma mensagem para o jogador)
            selected_attack_index = -1; 
        }
    }
	
	if(player.stamina > player.max_stamina) {
		player.stamina -= player.stamina - player.max_stamina;	
	}
	
	if(player.hp > player.max_hp) {
		player.hp -= player.hp - player.max_hp;	
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