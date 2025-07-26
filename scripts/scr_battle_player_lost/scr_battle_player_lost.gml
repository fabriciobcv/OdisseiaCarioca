function scr_battle_player_lost() {
    show_message("Derrota.");
    room_goto(GameOver);
    instance_destroy();
}