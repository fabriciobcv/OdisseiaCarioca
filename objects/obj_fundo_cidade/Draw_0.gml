offset += velocidade;

var largura = 480;

if (offset >= largura) {
    offset -= largura;
}

for (var i = -1; i <= room_width / largura + 1; i++) {
    draw_sprite(sprite_index, -1, i * largura - offset, y);
	

}