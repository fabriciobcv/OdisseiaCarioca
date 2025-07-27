if (!instance_exists(oBattle) || !instance_exists(obj_player)) {
    instance_destroy();
    exit; 
}

var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

// --- DESENHA A HUD ESTÁTICA ---
// (O código para desenhar as barras de HP, Stamina, etc. permanece o mesmo)
var hud_x = 10;
var hud_y = 10;
var player_instance = oBattle.player;
draw_sprite(spr_hud, 0, hud_x, hud_y);

var bar_offset_x = -11;
var bar_width = 178; 
var bar_height = 32;
var hp_bar_offset_y = 4;
var stamina_bar_offset_y = 48;
var level_bar_offset_y = 92;

draw_set_font(fnt_player_stats);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var text_x = hud_x + bar_offset_x + (bar_width / 2);

var hp_text_y = hud_y + hp_bar_offset_y + (bar_height / 2);
var hp_string = string(floor(player_instance.hp)) + "/" + string(player_instance.max_hp);
draw_text(text_x, hp_text_y, hp_string);

var stamina_text_y = hud_y + stamina_bar_offset_y + (bar_height / 2);
var stamina_string = string(floor(player_instance.stamina)) + "/" + string(player_instance.max_stamina);
draw_text(text_x, stamina_text_y, stamina_string);

var level_text_y = hud_y + level_bar_offset_y + (bar_height / 2);
var level_string = string(player_instance.level);
draw_text(text_x, level_text_y, level_string);


// --- LÓGICA DE BATALHA ---
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);

var px = 10;
var py = hud_y + sprite_get_height(spr_hud) + 20;

// Desenha HP dos inimigos
for (var i = 0; i < array_length(oBattle.inimigos); i++) {
    var inimigo = oBattle.inimigos[i];
    if (instance_exists(inimigo) && inimigo.is_alive) {
        draw_text(px, py, "Inimigo " + string(i+1) + " HP: " + string(inimigo.hp));
        py += 30;
    }
}

// Gerencia a UI do turno do jogador com base no estado
if (oBattle.battle_state == "turn_player") {
    py += 20;
    
    switch (oBattle.player_turn_state) {
        
        // Estado 1: Escolher entre Ataque e Item
        case "select_action":
            var attack_text = "- Ataques";
            var item_text = "- Itens";
            
            var is_hover_attack = point_in_rectangle(mx, my, px, py, px + string_width(attack_text), py + string_height(attack_text));
            draw_set_color(is_hover_attack ? c_yellow : c_white);
            draw_text(px, py, attack_text);
            if (is_hover_attack && mouse_check_button_pressed(mb_left)) {
                oBattle.player_turn_state = "select_attack";
            }
            py += 25;

            if (!oBattle.item_used_this_turn) {
                var is_hover_item = point_in_rectangle(mx, my, px, py, px + string_width(item_text), py + string_height(item_text));
                draw_set_color(is_hover_item ? c_yellow : c_white);
                draw_text(px, py, item_text);
                if (is_hover_item && mouse_check_button_pressed(mb_left)) {
                    oBattle.player_turn_state = "select_item";
                }
            }
            break;

        // Estado 2: Escolher um Ataque específico
        case "select_attack":
            var player_attacks = oBattle.player.ataques;
            for (var i = 0; i < array_length(player_attacks); i++) {
                // ... (lógica de desenho e hover dos ataques, como antes)
                var attack = player_attacks[i];
                var attack_text = attack.name + " (Custo: " + string(attack.cost) + ")";
                var is_hovering = point_in_rectangle(mx, my, px, py, px + string_width(attack_text), py + string_height(attack_text));
                draw_set_color(is_hovering ? c_yellow : c_white);
                draw_text(px, py, attack_text);

                if (is_hovering && mouse_check_button_pressed(mb_left)) {
                    oBattle.selected_attack_index = i;
                    oBattle.player_turn_state = "select_target";
                }
                py += 20;
            }
            // Botão Voltar
            var back_text = "Voltar";
            var is_hovering_back = point_in_rectangle(mx, my, px, py, px + string_width(back_text), py + string_height(back_text));
            draw_set_color(is_hovering_back ? c_yellow : c_white);
            draw_text(px, py, back_text);
            if (is_hovering_back && mouse_check_button_pressed(mb_left)) {
                oBattle.player_turn_state = "select_action";
            }
            break;

        // Estado 3: Escolher um Item específico
        case "select_item":
            for (var i = 0; i < ds_list_size(global.inventory); i++) {
                // ... (lógica de desenho e hover dos itens, como antes)
                 var item = global.inventory[| i];
                var item_text = item.name;
                var is_hovering_item = point_in_rectangle(mx, my, px, py, px + string_width(item_text), py + string_height(item_text));
                draw_set_color(is_hovering_item ? c_yellow : c_white);
                draw_text(px, py, item_text);

                if (is_hovering_item && mouse_check_button_pressed(mb_left)) {
                    oBattle.selected_item_index = i;
                    oBattle.player_turn_state = "select_target";
                }
                py += 20;
            }
             // Botão Voltar
            var back_text = "Voltar";
            var is_hovering_back = point_in_rectangle(mx, my, px, py, px + string_width(back_text), py + string_height(back_text));
            draw_set_color(is_hovering_back ? c_yellow : c_white);
            draw_text(px, py, back_text);
            if (is_hovering_back && mouse_check_button_pressed(mb_left)) {
                oBattle.player_turn_state = "select_action";
            }
            break;
            
        // Estado 4: Escolher o Alvo
        case "select_target":
            var action_name = (oBattle.selected_attack_index != -1) ? oBattle.player.ataques[oBattle.selected_attack_index].name : global.inventory[| oBattle.selected_item_index].name;
            draw_text(px, py, "Selecione o alvo para " + action_name);
             py += 25;
            // Botão Voltar
            var back_text = "Voltar";
            var is_hovering_back = point_in_rectangle(mx, my, px, py, px + string_width(back_text), py + string_height(back_text));
            draw_set_color(is_hovering_back ? c_yellow : c_white);
            draw_text(px, py, back_text);
            if (is_hovering_back && mouse_check_button_pressed(mb_left)) {
                oBattle.player_turn_state = "select_action";
                oBattle.selected_attack_index = -1;
                oBattle.selected_item_index = -1;
            }
            break;
    }
    draw_set_color(c_white);
}