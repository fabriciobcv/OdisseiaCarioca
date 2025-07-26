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
