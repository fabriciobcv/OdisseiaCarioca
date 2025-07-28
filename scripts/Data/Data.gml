global.data = {
	atk_level_multiplier: 3,
	max_hp_level_multiplier: 2,
	max_def_level_multiplier: 2,
	items: {
		"pocao": {
			name: "Pocao",
			identifier: "pocao",
			description: "Cura 20 de HP.",
			effect: "heal",
			power: 20,
			target: "ally"
		},
		"eter": {
			name: "Eter",
			identifier: "eter",
			description: "Restaura 15 de Stamina.",
			effect: "restore_stamina",
			power: 15,
			target: "ally"
		},
		"coxinha": {
			name: "Coxinha",
			identifier: "coxinha",
			price: 15,
			effect: "heal",
			power: 10,
			description: "Tem um gosto meio azedo. Recupera 10 de HP.",
			target: "ally"
		},
        "x-bacon": {
			name: "X-Bacon",
			identifier: "x-bacon",
			price: 25,
			effect: "heal",
			power: 25,
			description: "A quantidade de bacon depende da sua sorte. Recupera 25 de HP.",
			target: "ally"
		},
        "refrigerante": {
			name: "Refrigerante",
			identifier: "refrigerante",
			price: 10,
			effect: "restore_stamina",
			power: 20,
			description: "Pra rebater. Restaura 20 de Stamina.",
			target: "ally"
		}
	},
    // ADICIONE ESTA PARTE
    shop_items: ["coxinha", "x-bacon", "refrigerante"]
}

global.player_hp = 100;
global.player_max_hp = 100;
global.player_dinheiro = 0;
global.player_ataque = 10;