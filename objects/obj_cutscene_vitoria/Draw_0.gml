
parar_player()

var cam_x = camera_get_view_x(view_camera[0]);
var cam_y = camera_get_view_y(view_camera[0]);

draw_sprite(cutscene_sprite, 0, cam_x, cam_y);