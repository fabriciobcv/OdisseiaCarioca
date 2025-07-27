if (global.return_to_room == room) {
    if (instance_exists(obj_player)) {
        obj_player.x = global.return_x;
        obj_player.y = global.return_y;
    }
    global.return_to_room = noone;
}