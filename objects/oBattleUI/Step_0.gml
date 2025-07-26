if (oBattle.battle_state == "turn_player") {
	var player = obj_player;
    var atk_list = player.attack_list;
    var px = 20;
    var py_start = 20 + 30 + array_length(oBattle.inimigos) * 30 + 30;

    for (var i = 0; i < array_length(atk_list); i++) {
        var top = py_start + i * 30;
        var bottom = top + 25;
        var left = px - 5;
        var right = px + 200;

        if (mouse_check_button_pressed(mb_left) &&
            mouse_x > left && mouse_x < right &&
            mouse_y > top && mouse_y < bottom) {

            var atk = atk_list[i];
            oBattle.selected_attack = i;

            if (atk.alvo == "aoe") {
                aplicar_ataque(oBattle.player, i, noone);
                oBattle.advance_turn();
            }

            // se for "single", oBattle continuará aguardando clique no inimigo
            break;
        }
    }
}