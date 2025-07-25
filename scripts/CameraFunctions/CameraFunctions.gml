function deslocar_camera(x, y) {
	obj_camera.deslocamentoX = x;
	obj_camera.deslocamentoY  = y;
}

function resetar_deslocamento_camera() {
	deslocar_camera(0, 0)
}