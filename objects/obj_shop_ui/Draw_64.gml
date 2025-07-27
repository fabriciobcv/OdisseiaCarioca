if (is_open && instance_exists(obj_player)) {
    var ui_x = 50;
    var ui_y = 50;
    var item_height = 25;
    var ui_width = 250; // Largura da área da UI para detecção do mouse

    draw_set_font(fnt_player_stats);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);

    // Fundo semi-transparente para melhor legibilidade
    draw_set_color(c_black);
    draw_set_alpha(0.7);
    draw_rectangle(ui_x - 10, ui_y - 10, ui_x + ui_width + 10, 300, false);
    draw_set_alpha(1.0);

    // Título da Loja
    draw_set_color(c_white);
    draw_text(ui_x, ui_y, "Lanches do Mercenário");
    ui_y += 40;

    // Itens da Loja
    var shop_items_list = get_items(global.data.shop_items);
    var mx = device_mouse_x_to_gui(0);
    var my = device_mouse_y_to_gui(0);

    for (var i = 0; i < array_length(shop_items_list); i++) {
        var item = shop_items_list[i];
        var item_text = item.name + " - R$ " + string(item.price);
        var current_item_y = ui_y + (i * item_height);

        // Lógica de interação com o mouse
        if (point_in_rectangle(mx, my, ui_x, current_item_y, ui_x + ui_width, current_item_y + item_height)) {
            draw_set_color(c_yellow); // Cor de destaque
            if (mouse_check_button_pressed(mb_left)) {
                if (obj_player.money >= item.price) {
                    obj_player.money -= item.price;
                    add_item_to_inventory(item.identifier);
                    show_message("Você comprou: " + item.name);
                } else {
                    show_message("Dinheiro insuficiente!");
                }
            }
        } else {
            draw_set_color(c_white); // Cor padrão
        }
        draw_text(ui_x, current_item_y, item_text);
    }

    draw_set_color(c_white); // Reseta a cor

    // Dinheiro do Jogador
    ui_y += array_length(shop_items_list) * item_height + 20;
    draw_text(ui_x, ui_y, "Seu Dinheiro: R$ " + string(obj_player.money));

    // Botão de Fechar
    var close_text = "[Fechar Loja]";
    var close_y = ui_y + 40;
    if (point_in_rectangle(mx, my, ui_x, close_y, ui_x + string_width(close_text), close_y + item_height)) {
        draw_set_color(c_red);
        if (mouse_check_button_pressed(mb_left)) {
            is_open = false; // Apenas muda a flag
            destravar_player();
        }
    } else {
        draw_set_color(c_white);
    }
    draw_text(ui_x, close_y, close_text);
    draw_set_color(c_white);

} else if (is_open == false) {
    instance_destroy(); // Destroi a UI se ela não estiver mais aberta
}