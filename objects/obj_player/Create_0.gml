ataques = get_player_attacks();
movement_keys = ds_map_create();

flash = false;
flash_timer = 0;

ds_map_add(movement_keys, "left", ord("A"));
ds_map_add(movement_keys, "right", ord("D"));

inventory_instance = instance_create_layer(0, 0, "Instances", obj_inventory);
inventory_instance.is_open = false;

if (keyboard_check_pressed(ord("I"))) {
    inventory_instance.is_open = !inventory_instance.is_open;
}