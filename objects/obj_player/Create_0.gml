ataques = get_player_attacks();
movement_keys = ds_map_create();

flash = false;
flash_timer = 0;

ds_map_add(movement_keys, "left", ord("A"));
ds_map_add(movement_keys, "right", ord("D"));
