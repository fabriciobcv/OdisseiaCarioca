function parar_player() {
	obj_player.can_move = false;
	obj_player.sprite_index = spr_player_idle
}

function destravar_player() {
	obj_player.can_move = true;
}


function reset_player_bars(player) {
	player.hp = player.max_hp;
	player.stamina = player.max_stamina;
}

function get_xp_to_up(player) {
	return player.level * 100;
}

function get_player_attacks() {
    return [
        { name: "Ataque Rápido", power: 15, cost: -5, desc: "Um ataque veloz.", target_friends: false },
        { name: "Golpe Forte", power: 30, cost: 10, desc: "Um poderoso golpe que consome MP.", target_friends: false },
        { name: "Cura Leve", power: -25, cost: 15, desc: "Recupera um pouco de HP.", target_friends: true }
    ];
}