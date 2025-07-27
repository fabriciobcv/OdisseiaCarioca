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
deslocar_camera(100, 0);

turn_queue = array_create(1, player); 
turn_queue = array_concat(turn_queue, inimigos);
current_turn = 0;

selected_attack_index = -1; 
selected_item_index = -1; // Novo: para rastrear o item selecionado
item_used_this_turn = false; // Novo: para rastrear o uso do item
player_turn_state = "select_action";