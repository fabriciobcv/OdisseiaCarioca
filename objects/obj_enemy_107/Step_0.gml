 if (hp <= 0) {
    instance_destroy();
}
 
// distance_to_player = abs(x - obj_player.x);
// tolerancia = 2;

//if (distance_to_player <= 40 && instance_exists(obj_player)) {
//     dir = point_direction(x, y, obj_player.x, obj_player.y);

//    image_xscale = (obj_player.x < x) ? original_scale_x : -original_scale_x;

//    x += lengthdir_x(spd, dir);

//} else {
//     dist = point_distance(x, y, original_position_x, original_position_y);

//    if (dist > tolerancia) {
//         dir = point_direction(x, y, original_position_x, original_position_y);

//        image_xscale = (original_position_x < x) ? original_scale_x : -original_scale_x;

//        x += lengthdir_x(spd, dir);
//    } else {
//        x = original_position_x;
//    }
//}