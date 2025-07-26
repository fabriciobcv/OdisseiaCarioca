function scr_battle_turn_player() {
    // Se um ataque foi selecionado (pelo clique na UI), aguarda a seleção do alvo
    if (selected_attack_index != -1) {
        if (mouse_check_button_pressed(mb_left)) {
            var alvo = instance_position(mouse_x, mouse_y, obj_enemy_parent);
            if (alvo != noone) {
                var attack = player.ataques[selected_attack_index];
                with (alvo) {
                    hp -= calcular_dano(attack.power, alvo.def);
                    flash = true; 
                }
                selected_attack_index = -1; // Reseta a seleção para o próximo turno
                advance_turn();
            }
        }
    }
}