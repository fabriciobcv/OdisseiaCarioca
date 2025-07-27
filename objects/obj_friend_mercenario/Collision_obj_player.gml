// A loja só abre se o jogador ainda não tiver interagido com o mercenário
if (!has_interacted) {
    if (!instance_exists(obj_shop_ui)) {
        // Cria a camada de UI se ela não existir para garantir que a loja fique na frente
        if (!layer_exists("UI_Layer")) {
            layer_create(-10000, "UI_Layer");
        }
        
        // Cria a instância da loja na camada de UI
        var shop_ui = instance_create_layer(0, 0, "UI_Layer", obj_shop_ui);
        shop_ui.is_open = true;
        
        // Para o jogador para que ele possa interagir com a loja
        parar_player();
        
        // Define que a interação já ocorreu para não abrir a loja novamente
        has_interacted = true;
    }
}
