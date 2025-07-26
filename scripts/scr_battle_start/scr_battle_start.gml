function scr_battle_start() {
    current_turn = 0;
    var ent = turn_queue[current_turn];
    if (ent == player) {
        battle_state = "turn_player";
    } else {
        battle_state = "turn_enemy";
    }
}