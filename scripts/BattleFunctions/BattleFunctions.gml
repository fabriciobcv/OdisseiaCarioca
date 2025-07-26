function inicializar_batalha(self) {
    if (!variable_instance_exists(self, "player")) {
        self.player = instance_find(obj_player, 0);
    }
    if (!variable_instance_exists(self, "inimigos")) {
        self.inimigos = [];
    }

    self.battle_active = true;
    self.battle_state = "start";

    parar_player();
    deslocar_camera(100, 0);

    self.turn_queue = array_create(1, self.player);
    self.turn_queue = array_concat(self.turn_queue, self.inimigos);
    self.current_turn = 0;
}


function advance_turn() {
    current_turn += 1;
    if (current_turn >= array_length(turn_queue)) {
        current_turn = 0;
    }

    var ent = turn_queue[current_turn];

    if (!instance_exists(ent)) {
        advance_turn(); // pula mortos
    } else if (ent == player) {
        battle_state = "turn_player";
    } else if (object_is_ancestor(ent.object_index, obj_enemy_parent)) {
        battle_state = "turn_enemy";
    }
}

function all_dead(arr) {
    for (var i = 0; i < array_length(arr); i++) {
        if (instance_exists(arr[i])) return false;
    }
    return true;
}

function battle_is_player_dead(player) {
	return player.hp <= 0;
}