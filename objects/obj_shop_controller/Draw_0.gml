var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);
var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

var shop_x = gui_w * 0.1;
var shop_y = gui_h * 0.1;
var line_height = 30;
var tab_width = 120;
var col_width = 250;

draw_set_font(fnt_player_stats);
var color_default = c_white;
var color_hover = c_yellow;
var color_selected = c_green;

var buy_text = "Comprar";
var sell_text = "Vender";
var buy_tab_x = shop_x;
var sell_tab_x = buy_tab_x + tab_width;

var buy_tab_color = (shop_tab == "buy") ? color_selected : color_default;
var sell_tab_color = (shop_tab == "sell") ? color_selected : color_default;

var is_hover_buy = point_in_rectangle(mx, my, buy_tab_x, shop_y, buy_tab_x + string_width(buy_text), shop_y + line_height);
var is_hover_sell = point_in_rectangle(mx, my, sell_tab_x, shop_y, sell_tab_x + string_width(sell_text), shop_y + line_height);

if (shop_tab != "buy" && is_hover_buy) buy_tab_color = color_hover;
if (shop_tab != "sell" && is_hover_sell) sell_tab_color = color_hover;

draw_set_color(buy_tab_color);
draw_text(buy_tab_x, shop_y, buy_text);

draw_set_color(sell_tab_color);
draw_text(sell_tab_x, shop_y, sell_text);

if (mouse_check_button_pressed(mb_left)) {
    if (is_hover_buy) shop_tab = "buy";
    else if (is_hover_sell) shop_tab = "sell";
}

var info_y = shop_y + line_height * 2;
draw_set_color(c_white);
draw_text(shop_x, info_y, "Dinheiro: " + string(obj_player.dinheiro));

var list_y_start = info_y + line_height * 2;

if (shop_tab == "buy") {
    draw_text(shop_x, list_y_start - line_height, "Itens à Venda:");
    for (var i = 0; i < array_length(global.data.shop_items); i++) {
        var item_name = global.data.shop_items[i];
        var item = global.data.items[$ item_name];
        var item_y = list_y_start + i * line_height;
        var item_display_text = item.name + " - Preço: " + string(item.buy_price);
        var is_hover = point_in_rectangle(mx, my, shop_x, item_y, shop_x + string_width(item_display_text), item_y + line_height);
        
        draw_set_color(is_hover ? color_hover : color_default);
        draw_text(shop_x, item_y, item_display_text);

        if (is_hover && mouse_check_button_pressed(mb_left)) buy_item(item_name);
    }
} else {
    draw_text(shop_x, list_y_start - line_height, "Seu Inventário:");
    for (var i = 0; i < ds_list_size(global.inventory); i++) {
        var item = global.inventory[| i];
        var item_y = list_y_start + i * line_height;
        var item_display_text = item.name + " - Vender por: " + string(item.sell_price);
        var is_hover = point_in_rectangle(mx, my, shop_x, item_y, shop_x + string_width(item_display_text), item_y + line_height);

        draw_set_color(is_hover ? color_hover : color_default);
        draw_text(shop_x, item_y, item_display_text);
        
        if (is_hover && mouse_check_button_pressed(mb_left)) {
            sell_item(i);
            break;
        }
    }
}