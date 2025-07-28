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
        advance_turn();
    } else if (ent == player) {
        battle_state = "turn_player";
        oBattle.player_turn_state = "select_action"; // Reseta para o menu principal
        item_used_this_turn = false; 
    } else if (object_is_ancestor(ent.object_index, obj_enemy_parent)) {
		if(!ent.is_alive) {
			advance_turn();	
		} else {
			battle_state = "turn_enemy";
		}
    }
}


function end_battle() {
	battle_state = "ended"
}

function all_dead(arr) {
    return array_all(arr, function(inimigo) {
		return !inimigo.is_alive;
	})
}

function battle_is_player_dead(player) {
	return player.hp <= 0;
}

function calcular_dano(atk, def) {

	return round(atk / (def / 100)) / 2;
}

function calcular_cura(cura) {
	return -cura;	
}