function scr_battle_turn_enemy() {
    var ent = turn_queue[current_turn];

    if (instance_exists(ent) && ent.can_attack) {
        with (ent) {
            if (instance_exists(other.player)) {
                other.player.hp -= calcular_dano(ent.atk, other.player.def);
                other.player.flash = true;
            }
        }
    }
    advance_turn();
}