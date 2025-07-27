function get_drops(inimigo) {
    // Verifica de forma segura se a variável 'drops' existe no inimigo
    if (variable_instance_exists(inimigo.id, "drops")) {
        // Itera sobre a lista de possíveis drops do inimigo
        for (var i = 0; i < array_length(inimigo.drops); i++) {
            var drop_info = inimigo.drops[i];
            
            // Rola um "dado" (um número aleatório de 0.0 a 1.0)
            if (random(1) <= drop_info.chance) {
                // Se o resultado for menor ou igual à chance, o item é dropado
                add_item_to_inventory(drop_info.item_name);
                show_message("Inimigo deixou cair uma " + global.data.items[$ drop_info.item_name].name + "!");
            }
        }
    }
}