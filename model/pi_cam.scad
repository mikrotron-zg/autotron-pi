// RPi camera module 3D model - 5MP, wide angle lens (160 deg)

include <common.scad>;

// Defines smoothness of rounded objects
$fn = 80;

// Board dimensions
pi_cam_length = 25.0;
pi_cam_width = 24.0;
pi_cam_thickness = 1.0;

// Mount holes dimensions
pi_cam_mh_dia = 2.2*hdc; // See common.scad for hdc definition
pi_cam_mh_center = 2.1;
pi_cam_mh_xy = [ [pi_cam_mh_center, 8.4, -ex],
             [pi_cam_mh_center, pi_cam_width - 2.4, -ex],
             [pi_cam_length - pi_cam_mh_center, pi_cam_width - 2.4, -ex],
             [pi_cam_length - pi_cam_mh_center, 8.4, -ex]
           ];

// Flat cable connector dimensions
pi_cam_conn_length = 21.8;
pi_cam_conn_width = 5.2;
pi_cam_conn_height = 2.54;

// Entry point
pi_cam();

module pi_cam(){
    // Draw board
    difference(){
        color("DarkSlateGray") cube([pi_cam_length, pi_cam_width, pi_cam_thickness]);
        // Mount holes
        for (i = [0:len(pi_cam_mh_xy)-1]) pi_cam_mount_hole(pi_cam_mh_xy [i]);
    }
    // Draw flat cable connector
    translate([pi_cam_length/2 - pi_cam_conn_length/2, 0, pi_cam_thickness]) 
        color("Beige") cube([pi_cam_conn_length, pi_cam_conn_width, pi_cam_conn_height]);
    // Draw lens
    translate([pi_cam_length/2, 15.25, pi_cam_thickness]) pi_cam_lens();
}

module pi_cam_mount_hole(vect){
    translate(vect) color("LightYellow") cylinder(d=pi_cam_mh_dia, pi_cam_thickness + 2*ex);
}

module pi_cam_lens(){
    base_width = 13.5;
    base_height = 3.5;
    body_height = 14.5;
    glass_radius = 6.5;
    
    color("DimGray"){
        translate([0, 0, base_height/2]) 
            cube([base_width, base_width, base_height], center=true);
        cylinder(d=base_width, h=body_height);
        translate([0, 0, body_height - 3]) cylinder(d=base_width+2, 3);
    }
    translate([0, 0, body_height - glass_radius + 2.5]) color("Ivory")
        sphere(r=glass_radius);
}