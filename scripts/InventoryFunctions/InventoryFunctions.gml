function initialize_inventory() {
    global.inventory = ds_list_create();
    // Corrigido: Usando as chaves sem acento definidas em global.data
    add_item_to_inventory("pocao");
    add_item_to_inventory("pocao");
    add_item_to_inventory("eter");
}

function add_item_to_inventory(item_name) {
    var item = get_item_details(item_name);
    if (item != undefined) {
        ds_list_add(global.inventory, item);
    }
}

function get_item_details(item_name) {
    if (struct_exists(global.data.items, item_name)) {
        return global.data.items[$ item_name];
    }
    return undefined;
}

function use_item(item_index, target) {
    if (item_index < 0 || item_index >= ds_list_size(global.inventory)) {
        return;
    }

    var item = global.inventory[| item_index];
    switch (item.effect) {
        case "heal":
            target.hp += item.power;
            if (target.hp > target.max_hp) {
                target.hp = target.max_hp;
            }
            break;
        case "restore_stamina":
            target.stamina += item.power;
            if (target.stamina > target.max_stamina) {
                target.stamina = target.max_stamina;
            }
            break;
    }
    ds_list_delete(global.inventory, item_index);
}