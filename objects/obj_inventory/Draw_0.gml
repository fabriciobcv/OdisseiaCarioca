if (is_open) {
    var inv_x = 50;
    var inv_y = 50;
    var item_height = 20;
    draw_set_font(fnt_player_stats);
    draw_set_color(c_white);
    draw_text(inv_x, inv_y, "Inventário");

    for (var i = 0; i < ds_list_size(global.inventory); i++) {
        var item = global.inventory[| i];
        draw_text(inv_x, inv_y + (i + 1) * item_height, item.name);
    }
}