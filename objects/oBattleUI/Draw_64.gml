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