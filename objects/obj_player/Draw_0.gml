// Se o timer de flash estiver ativo, aplica o efeito
if (flash_timer > 0) {
    // Ativa um "fog" de GPU para colorir o sprite de branco
    gpu_set_fog(true, c_white, 0, 1);
    
    // Desenha o sprite do jogador com o efeito aplicado
    draw_self();
    
    // Desliga o fog para não afetar outros objetos na tela
    gpu_set_fog(false, c_black, 0, 0);
} else {
    // Se não houver flash, apenas desenha o sprite normalmente
    draw_self();
}