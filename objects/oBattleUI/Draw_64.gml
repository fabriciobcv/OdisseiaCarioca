if (!instance_exists(oBattle) || !instance_exists(obj_player)) {
    instance_destroy();
    exit; 
}

var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

//==============================================================================
// 1. VARIÁVEIS DE CONTROLE DE POSIÇÃO E LAYOUT
//==============================================================================

// Posição Base da UI
var ui_base_x = 10;
var ui_base_y = 10;

// Posição da Lista de Ações (Ataques, Itens, etc.)
var action_list_x = ui_base_x;
var action_list_y = ui_base_y + sprite_get_height(spr_hud) + 20;

// Espaçamento Vertical
var line_spacing = 25;
var section_spacing = 20;

// Cores
var color_default = c_white;
var color_hover = c_yellow;
var color_selected = c_green;

//==============================================================================
// 2. DESENHO DA UI
//==============================================================================

// --- HUD Estática (Barras de Status) ---
draw_sprite(spr_hud, 0, ui_base_x, ui_base_y);

draw_set_font(fnt_player_stats);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var player_instance = oBattle.player;
var bar_offset_x = -11;
var bar_width = 178; 
var bar_height = 32;
var text_x = ui_base_x + bar_offset_x + (bar_width / 2);

// HP
var hp_y = ui_base_y + 4 + (bar_height / 2);
draw_text(text_x, hp_y, string(floor(player_instance.hp)) + "/" + string(player_instance.max_hp));

// Stamina
var stamina_y = ui_base_y + 48 + (bar_height / 2);
draw_text(text_x, stamina_y, string(floor(player_instance.stamina)) + "/" + string(player_instance.max_stamina));

// Level
var level_y = ui_base_y + 92 + (bar_height / 2);
draw_text(text_x, level_y, string(player_instance.level));


// --- Informações Dinâmicas da Batalha ---
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var px = action_list_x;
var py = action_list_y;

// HP dos Inimigos
for (var i = 0; i < array_length(oBattle.inimigos); i++) {
    var inimigo = oBattle.inimigos[i];
    if (instance_exists(inimigo) && inimigo.is_alive) {
        draw_text(px, py, "Inimigo " + string(i+1) + " HP: " + string(inimigo.hp));
        py += 30;
    }
}

py += section_spacing;

// --- Menus do Turno do Jogador ---
if (oBattle.battle_state == "turn_player") {
    
    switch (oBattle.player_turn_state) {
        
        // Estado 1: Escolher entre Ataque e Item
        case "select_action":
            var attack_text = "- Ataques";
            var item_text = "- Itens";
            
            var is_hover_attack = point_in_rectangle(mx, my, px, py, px + string_width(attack_text), py + string_height(attack_text));
            draw_set_color(is_hover_attack ? color_hover : color_default);
            draw_text(px, py, attack_text);
            if (is_hover_attack && mouse_check_button_pressed(mb_left)) {
                oBattle.player_turn_state = "select_attack";
            }
            py += line_spacing;

            if (!oBattle.item_used_this_turn) {
                var is_hover_item = point_in_rectangle(mx, my, px, py, px + string_width(item_text), py + string_height(item_text));
                draw_set_color(is_hover_item ? color_hover : color_default);
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
                var attack = player_attacks[i];
                var attack_text = attack.name + " (Custo: " + string(attack.cost) + ")";
                var is_hovering = point_in_rectangle(mx, my, px, py, px + string_width(attack_text), py + string_height(attack_text));
                
                draw_set_color(is_hovering ? color_hover : color_default);
                draw_text(px, py, attack_text);

                if (is_hovering && mouse_check_button_pressed(mb_left)) {
                    oBattle.selected_attack_index = i;
                    oBattle.player_turn_state = "select_target";
                }
                py += line_spacing;
            }
            
            var back_text = "Voltar";
            var is_hovering_back = point_in_rectangle(mx, my, px, py, px + string_width(back_text), py + string_height(back_text));
            draw_set_color(is_hovering_back ? color_hover : color_default);
            draw_text(px, py, back_text);
            if (is_hovering_back && mouse_check_button_pressed(mb_left)) {
                oBattle.player_turn_state = "select_action";
            }
            break;

        // Estado 3: Escolher um Item específico
        case "select_item":
            for (var i = 0; i < ds_list_size(global.inventory); i++) {
                var item = global.inventory[| i];
                var item_text = item.name;
                var is_hovering_item = point_in_rectangle(mx, my, px, py, px + string_width(item_text), py + string_height(item_text));
                
                draw_set_color(is_hovering_item ? color_hover : color_default);
                draw_text(px, py, item_text);

                if (is_hovering_item && mouse_check_button_pressed(mb_left)) {
                    oBattle.selected_item_index = i;
                    oBattle.player_turn_state = "select_target";
                }
                py += line_spacing;
            }

            var back_text = "Voltar";
            var is_hovering_back = point_in_rectangle(mx, my, px, py, px + string_width(back_text), py + string_height(back_text));
            draw_set_color(is_hovering_back ? color_hover : color_default);
            draw_text(px, py, back_text);
            if (is_hovering_back && mouse_check_button_pressed(mb_left)) {
                oBattle.player_turn_state = "select_action";
            }
            break;
            
        // Estado 4: Escolher o Alvo
        case "select_target":
            var action_name = (oBattle.selected_attack_index != -1) 
                ? oBattle.player.ataques[oBattle.selected_attack_index].name 
                : global.inventory[| oBattle.selected_item_index].name;
            
            draw_text(px, py, "Selecione o alvo para " + action_name);
            py += line_spacing;
            
            var back_text = "Voltar";
            var is_hovering_back = point_in_rectangle(mx, my, px, py, px + string_width(back_text), py + string_height(back_text));
            draw_set_color(is_hovering_back ? color_hover : color_default);
            draw_text(px, py, back_text);
            if (is_hovering_back && mouse_check_button_pressed(mb_left)) {
                oBattle.player_turn_state = "select_action";
                oBattle.selected_attack_index = -1;
                oBattle.selected_item_index = -1;
            }
            break;
    }
}

draw_set_color(c_white); // Resetar a cor no final