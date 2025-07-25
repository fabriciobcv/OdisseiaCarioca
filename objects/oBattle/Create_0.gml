// Certifique-se de que estas variáveis sejam definidas externamente:
// `player` e `inimigos` devem ser atribuídos pelo oBattleTrigger antes da criação ou logo após.

// Segurança: caso não estejam definidas, usa valores padrão
if (!variable_instance_exists(id, "player")) {
    player = instance_find(obj_player, 0);
}
if (!variable_instance_exists(id, "inimigos")) {
    inimigos = [];
}

parar_player();
deslocar_camera(100, 0)

// Montar a fila de turnos
turn_queue = array_create(1, player); // cria array com o player
turn_queue = array_concat(turn_queue, inimigos); // adiciona inimigos depois
current_turn = 0;