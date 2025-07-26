if (hp <= 0) {
    sprite_index= spr_player_dead;
}

if(can_move){
	if keyboard_check(movement_keys[? "left"]){
		x -=spd
		image_xscale =-1
	}

	if keyboard_check(movement_keys[? "right"]){
		x +=spd
		image_xscale =1
	}
	if (keyboard_check(movement_keys[? "right"]) || keyboard_check(movement_keys[? "left"])){
	 sprite_index = spr_player_run
	}else{
	 sprite_index = spr_player_idle
	}
}

// Gerencia o temporizador do flash
if (flash) {
    flash_timer = 6; // Duração do flash em frames (6 frames = 0.1s a 60FPS)
    flash = false;
}

if (flash_timer > 0) {
    flash_timer -= 1;
}