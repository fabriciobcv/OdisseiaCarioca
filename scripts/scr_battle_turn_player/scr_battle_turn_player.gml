function scr_battle_turn_player() {
    if (selected_attack_index != -1) {
        var attack = player.ataques[selected_attack_index];
        
        // Verifica se há stamina suficiente
        if (player.stamina >= attack.cost) {
            if (mouse_check_button_pressed(mb_left)) {
                var alvo = instance_position(mouse_x, mouse_y, obj_enemy_parent);
                if (alvo != noone) {
                    // Deduz a stamina
                    player.stamina -= attack.cost;

                    with (alvo) {
                        hp -= calcular_dano(attack.power, alvo.def);
                        flash = true;
                    }
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
}