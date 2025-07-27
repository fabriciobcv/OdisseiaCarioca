// Adicione esta parte para iniciar o temporizador
if (flash) {
    flash_timer = 6; // Define a duração do flash
    flash = false;   // Reseta a variável gatilho
}

// O código existente continua aqui
if (flash_timer > 0) {
    flash_timer -= 1;
}

if (hp <= 0) {
	visible = false;
	is_alive = false;
	can_attack = false;
}