// Se o timer de flash estiver ativo, aplica o efeito
if (flash_timer > 0) {
    gpu_set_fog(true, c_white, 0, 1);
    draw_self();
    gpu_set_fog(false, c_black, 0, 0);
} else {
    // Desenha o sprite normalmente se não houver flash
    draw_self();
}