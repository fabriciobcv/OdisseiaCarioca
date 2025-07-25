global.party = [{
	name: "Ollug",
	hp: 100,
	hpMax: 100,
	mp: 10,
	mpMax: 15,
	strength: 6,
	sprites: {idle: spr_player_idle, attack: spr_player_idle, defend: spr_player_idle, down: spr_player_idle},
	actions: []
}]

global.enemies = {
	onibus: {
		name: "107",
		hp: 100,
		hpMax: 100,
		mp: 10,
		mpMax: 15,
		strength: 6,
		sprites: {idle: spr_enemy_idle, attack: spr_enemy_idle, defend: spr_enemy_idle, down: spr_enemy_idle},
		actions: [],
		xpValue: 15,
		AIscript: function() {
		
		}
	}
}