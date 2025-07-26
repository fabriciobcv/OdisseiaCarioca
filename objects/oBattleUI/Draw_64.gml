// Verifica se a instância de batalha existe antes de desenhar qualquer coisa
if (!instance_exists(oBattle) || !instance_exists(obj_player)) {
    exit; // Sai do evento de desenho se a batalha não existir
}

// Exemplo de HUD bem simples
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_font(-1); // usa fonte padrão

var px = 20;
var py = 20;

// Desenha HP do player
if (instance_exists(oBattle.player)) {
    draw_text(px, py, "Player HP: " + string(oBattle.player.hp));
    py += 30;
}

// Desenha HP dos inimigos
for (var i = 0; i < array_length(oBattle.inimigos); i++) {
    var inimigo = oBattle.inimigos[i];
    if (instance_exists(inimigo)) {
        draw_text(px, py, "Inimigo " + string(i+1) + " HP: " + string(inimigo.hp));
        py += 30;
    }
}

// Desenha a lista de ataques do player durante o turno dele
if (oBattle.battle_state == "turn_player") {
    py += 20;
    draw_text(px, py, "Selecione um ataque:");
    py += 25;

    var player_attacks = oBattle.player.ataques;
    for (var i = 0; i < array_length(player_attacks); i++) {
        var attack = player_attacks[i];
        var attack_text = attack.name + " (Poder: " + string(attack.power) + ")";
        
        // Destaca o ataque selecionado
        if (oBattle.selected_attack_index == i) {
            draw_set_color(c_yellow);
        } else {
            draw_set_color(c_white);
        }
        
        draw_text(px, py, attack_text);
        py += 20;
    }
    draw_set_color(c_white);
}