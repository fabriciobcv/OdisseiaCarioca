function initialize_inventory() {
    global.inventory = ds_list_create();
    // Adiciona alguns itens iniciais para teste
    add_item_to_inventory("Poção");
    add_item_to_inventory("Poção");
    add_item_to_inventory("Éter");
}

function add_item_to_inventory(item_name) {
    var item = get_item_details(item_name);
    if (item != undefined) {
        ds_list_add(global.inventory, item);
    }
}

function get_item_details(item_name) {
    switch (item_name) {
        case "Poção":
            return {
                name: "Poção",
                description: "Cura 20 de HP.",
                effect: "heal",
                power: 20,
                target: "ally" // Pode ser 'ally', 'enemy' ou 'self'
            };
        case "Éter":
            return {
                name: "Éter",
                description: "Restaura 15 de Stamina.",
                effect: "restore_stamina",
                power: 15,
                target: "ally"
            };
        default:
            return undefined;
    }
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