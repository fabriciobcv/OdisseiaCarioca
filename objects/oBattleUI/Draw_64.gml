if (!instance_exists(oBattle) || !instance_exists(obj_player)) {
    instance_destroy();
    exit; 
}

var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

// --- DESENHA A HUD ESTÁTICA ---
var hud_x = 10;
var hud_y = 10;
var player_instance = oBattle.player;

// Desenha a imagem base da HUD com as barras já inclusas
draw_sprite(spr_hud, 0, hud_x, hud_y);

// --- TEXTOS DA HUD ---
var bar_offset_x = -11;
var bar_width = 178; 
var bar_height = 32;

// Posições dos textos
var hp_bar_offset_y = 4;
var stamina_bar_offset_y = 48;
var level_bar_offset_y = 92;

// Configurações da fonte
draw_set_font(fnt_player_stats);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var text_x = hud_x + bar_offset_x + (bar_width / 2);

// Texto de HP
var hp_text_y = hud_y + hp_bar_offset_y + (bar_height / 2);
var hp_string = string(floor(player_instance.hp)) + "/" + string(player_instance.max_hp);
draw_text(text_x, hp_text_y, hp_string);

// Texto de Stamina
var stamina_text_y = hud_y + stamina_bar_offset_y + (bar_height / 2);
var stamina_string = string(floor(player_instance.stamina)) + "/" + string(player_instance.max_stamina);
draw_text(text_x, stamina_text_y, stamina_string);

// Texto de Level
var level_text_y = hud_y + level_bar_offset_y + (bar_height / 2);
var level_string = string(player_instance.level);
draw_text(text_x, level_text_y, level_string);


// --- LÓGICA ANTIGA (Inimigos e Ataques) ---
// Reseta alinhamento e cor para o resto da UI
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);

// Define a posição inicial para os textos dos inimigos, abaixo da HUD
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

// Lógica de seleção de ataque
if (oBattle.battle_state == "turn_player") {
    py += 20;
    if (oBattle.selected_attack_index == -1) {
        draw_text(px, py, "Selecione um ataque:");
    } else {
        draw_text(px, py, "Selecione um alvo ou troque o ataque:");
    }
    
    py += 25;

    var player_attacks = oBattle.player.ataques;
    for (var i = 0; i < array_length(player_attacks); i++) {
        var attack = player_attacks[i];
        var attack_text = attack.name + " (Custo: " + string(attack.cost) + ")";
        
        var text_width = string_width(attack_text);
        var text_height = string_height(attack_text);
        var is_hovering = point_in_rectangle(mx, my, px, py, px + text_width, py + text_height);
        
        if (oBattle.selected_attack_index == i) {
            draw_set_color(c_green);
        } else if (is_hovering) {
            draw_set_color(c_yellow);
        } else {
            draw_set_color(c_white);
        }
        
        if (is_hovering && mouse_check_button_pressed(mb_left)) {
            if (oBattle.selected_attack_index == i) {
                oBattle.selected_attack_index = -1;
            } else {
                oBattle.selected_attack_index = i;
            }
        }

        draw_text(px, py, attack_text);
        py += 20;
    }
    draw_set_color(c_white);
}