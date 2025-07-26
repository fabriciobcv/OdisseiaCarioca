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

function get_player_attacks() {
    return [
        { name: "Ataque Rápido", power: 15, cost: -5, desc: "Um ataque veloz." },
        { name: "Golpe Forte", power: 30, cost: 10, desc: "Um poderoso golpe que consome MP." },
        { name: "Cura Leve", power: -25, cost: 15, desc: "Recupera um pouco de HP." }
    ];
}