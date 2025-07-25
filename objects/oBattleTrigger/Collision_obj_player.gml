show_debug_message("Colidiu")

if (!activated) {
    activated = true;

    // Criar os inimigos nas posições relativas
    var enemies = [];

    for (var i = 0; i < array_length(enemy_group); i++) {
        var info = enemy_group[i];
        var inst = instance_create_layer(x + info.x_off, y + info.y_off, "Instances", info.tipo);
        array_push(enemies, inst);
    }

    // Criar o controlador da batalha
    if (!instance_exists(oBattle)) {
        var battle = instance_create_layer(x, y, "Instances", oBattle);
        battle.player = other.id; // o jogador que colidiu
        battle.inimigos = enemies;
    }

    // Destruir o trigger (opcional)
    instance_destroy();
}