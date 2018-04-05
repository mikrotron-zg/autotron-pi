// L298 motor driver module 3D model

include <common.scad>;

// Defines smoothness of rounded objects
$fn = 80;

// Board dimensions: mdb = motor driver board
mdb_length = 55.0;
mdb_width = 49.7;
mdb_height = 1.6;
mdb_corner_radius = 5.0;

// Mount holes dimensions
mdb_mh_dia = 3.6*hdc; // See common.scad for hdc definition
mdb_mh_center = 5.0;
mdb_mh_xy = [ [mdb_mh_center, mdb_mh_center, -ex],
             [mdb_mh_center, mdb_width - mdb_mh_center, -ex],
             [mdb_length - mdb_mh_center, mdb_width - mdb_mh_center, -ex],
             [mdb_length - mdb_mh_center, mdb_mh_center, -ex]
           ];

// Heatsink dimensions
hs_width = 16.0;
hs_length = 23.2;
hs_height = 25.0;
hs_thickness = 0.7;

// Connectors dimensions 

// mc = motor connector
mc_length = 10.40;
mc_width = 7.40;
mc_height = 10.0;
mc_x = 32.6;

// pc = power connector
pc_length = 15.0;
pc_width = 7.5;
pc_height = 10.0;
pc_x = 45.3;
pc_y = 17.2;

// pb = power button
pb_width1 = 8.0;
pb_width2 = 3.4;
pb_height1 = 8.5;
pb_height2 = 5.5;
pb_x = pc_x;
pb_y = pc_y + pc_length + 0.5;

// ip = input pins
ip_x = 37.2;
ip_y = 19.1;

// Entry point
L298_motor_driver();

module L298_motor_driver(){
    // Draw board
    difference(){
        color("DarkSlateGray") 
            rounded_rect(mdb_length, mdb_width, mdb_height, mdb_corner_radius);
        // Mount holes
        for (i = [0:len(mdb_mh_xy)-1]) mdb_mount_hole(mdb_mh_xy [i]);
    }
    // Draw elements on the board
    translate([0, 0, mdb_height]){
        translate([0, mdb_width/2 - hs_length/2, 0]) color("DimGray") mdb_heatsink();
        translate([mc_x, 0, 0]) {
            motor_connector();
            translate([0, mdb_width - mc_width, 0]) motor_connector();
        }
        translate([pc_x, pc_y, 0]) power_connector();
        translate([pb_x, pb_y, 0]) power_button();
        translate([ip_x, ip_y, 0]) header_pin(4, 2);
    }
}

module mdb_mount_hole(vect){
    translate(vect) color("LightYellow") cylinder(d=mdb_mh_dia, mdb_height + 2*ex);
}

module mdb_heatsink(){
    for (i = [0:5]) translate([0, i*(hs_length - hs_thickness)/5 , 0]) 
        cube([hs_width/2, hs_thickness, hs_height]);
    
    translate([hs_width/2, 0, 0]){
        translate([-hs_thickness, 0, 0]) 
            cube([2*hs_thickness, hs_length, hs_height]);
        cube([hs_width/2, hs_thickness, hs_height]);
        translate([0, hs_length - hs_thickness, 0]) 
            cube([hs_width/2, hs_thickness, hs_height]);
    }
}

module motor_connector(){
    color("SpringGreen") cube([mc_length, mc_width, mc_height]);
}

module power_connector(){
    color("SteelBlue") cube([pc_width, pc_length, pc_height]);
}

module power_button(){
    trans = pb_width1/2 - pb_width2/2;
    color("White") cube([pb_width1, pb_width1, pb_height1]);
    translate([trans, trans, pb_height1])
        color("SteelBlue") cube([pb_width2, pb_width2, pb_height2]);
}