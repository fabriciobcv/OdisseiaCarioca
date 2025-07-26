
function state_start() {
    current_turn = 0;
    var ent = turn_queue[current_turn];

    if (ent == player) {
        battle_state = state_turn_player;
    } else {
        battle_state = state_turn_enemy;
    }
}

function state_turn_player() {
    if (selected_attack_index != -1) {
        if (mouse_check_button_pressed(mb_left)) {
            var alvo = instance_position(mouse_x, mouse_y, obj_enemy_parent);
            if (alvo != noone) {
                var attack = player.ataques[selected_attack_index];
                with (alvo) {
                    hp -= calcular_dano(attack.power, alvo.def);
                    flash = true;
                }
                selected_attack_index = -1;
                advance_turn();
            }
        }
    }
}

function state_turn_enemy() {
    // Lógica do estado "turn_enemy"
    var ent = turn_queue[current_turn];
    if (instance_exists(ent)) {
        with (ent) {
            if (instance_exists(other.player)) {
				
                other.player.hp -= calcular_dano(atk, other.player.def);
                other.player.flash = true;
            }
        }
    }
    advance_turn();
}

function state_player_won() {
    show_message("Vitória!");
    instance_destroy();
}

function state_player_lost() {
    show_message("Derrota.");
    room_goto(GameOver);
    instance_destroy();
}