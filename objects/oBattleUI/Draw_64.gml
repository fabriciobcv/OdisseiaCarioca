if (!instance_exists(oBattle) || !instance_exists(obj_player)) {
    exit;
}

// Pega as coordenadas do mouse na camada de GUI (ESSA É A CORREÇÃO PRINCIPAL)
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_font(-1);

var px = 20;
var py = 20;

if (instance_exists(oBattle.player)) {
    draw_text(px, py, "Player HP: " + string(oBattle.player.hp));
    py += 30;
}

for (var i = 0; i < array_length(oBattle.inimigos); i++) {
    var inimigo = oBattle.inimigos[i];
    if (instance_exists(inimigo)) {
        draw_text(px, py, "Inimigo " + string(i+1) + " HP: " + string(inimigo.hp));
        py += 30;
    }
}

if (oBattle.battle_state == "turn_player") {
    py += 20;
    
    // Mostra uma instrução que muda dependendo do estado
    if (oBattle.selected_attack_index == -1) {
        draw_text(px, py, "Selecione um ataque:");
    } else {
        draw_text(px, py, "Selecione um alvo:");
    }
    
    py += 25;

    var player_attacks = oBattle.player.ataques;
    for (var i = 0; i < array_length(player_attacks); i++) {
        var attack = player_attacks[i];
        var attack_text = attack.name + " (Poder: " + string(attack.power) + ")";
        
        var text_width = string_width(attack_text);
        var text_height = string_height(attack_text);
        
        var is_hovering = point_in_rectangle(mx, my, px, py, px + text_width, py + text_height);
        
        // Define a cor do texto para dar feedback ao jogador
        if (oBattle.selected_attack_index == i) {
            draw_set_color(c_green); // Verde: ataque selecionado
        } else if (is_hovering) {
            draw_set_color(c_yellow); // Amarelo: mouse sobre a opção
        } else {
            draw_set_color(c_white); // Branco: padrão
        }
        
        // Se o jogador clicar e o mouse estiver sobre o texto, seleciona o ataque
        if (is_hovering && mouse_check_button_pressed(mb_left) && oBattle.selected_attack_index == -1) {
            oBattle.selected_attack_index = i;
        }

        draw_text(px, py, attack_text);
        py += 20;
    }
    draw_set_color(c_white); // Reseta a cor no final
}