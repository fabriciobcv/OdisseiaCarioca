if not instance_exists(target) exit;
x = lerp(x, target.x, 0.1)
y = lerp(y, target.y - cam_height/4, 0.1)
camera_set_view_pos(view_camera[0], x - cam_width/2 + deslocamentoX, y-cam_height/2 + deslocamentoY)