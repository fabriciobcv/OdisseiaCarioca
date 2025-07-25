// Verificar fim da batalha
if (!instance_exists(oBattleUI)) {
	instance_create_layer(0, 0, 0, oBattleUI);
}

if (battle_active && battle_state != "end") {
    if (array_length(inimigos) == 0 || all_dead(inimigos)) {
        battle_state = "end";
    }
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
        // Espera ação do jogador (input fica no Step de oBattle ou via interface)
        // Exemplo simplificado:
        if (mouse_check_button_pressed(mb_left)) {
            var alvo = instance_position(mouse_x, mouse_y, obj_enemy_parent);
            if (alvo != noone) {
                with (alvo) {
                    hp -= 20;
                    if (hp <= 0) instance_destroy();
                }
                advance_turn();
            }
        }
        break;

    case "turn_enemy":
        var ent = turn_queue[current_turn];
        if (instance_exists(ent)) {
            with (ent) {
                if (instance_exists(other.player)) {
                    other.player.hp -= 10; // ataque simples
                }
            }
        }
        advance_turn();
        break;

    case "end":
        show_message("Vitória!");
        instance_destroy(); // remove o controlador da batalha
        break;
}