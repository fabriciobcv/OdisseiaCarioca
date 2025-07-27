if (position_meeting(mouse_x, mouse_y, id)) {
    image_alpha = 1; // botão brilhante ou destacado
} else {
    image_alpha = 0.8; // opaco quando não está sob o mouse
}