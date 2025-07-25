function NewEncounter(_enemies) {
	instance_create_depth(
		obj_camera.x,
		obj_camera.y,
		-9999,
		oBattle,
		{
			enemies: _enemies, creator: id		
		}
	);

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