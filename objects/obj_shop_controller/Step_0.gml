if (keyboard_check_pressed(vk_escape)) {
    if (global.return_to_room != noone) {
        room_goto(global.return_to_room);
    } else {
        room_goto(Fase_SantaCruz);
    }
}