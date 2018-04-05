// DC geared right angle motor model

include <common.scad>;

// Defines smoothness of rounded objects
$fn = 80;

// Mount holes
motor_mh_dia = 3.0*hdc; // See common.scad for hdc definition
motor_mh_x = 32.0;
motor_mh_y1 = 2.5;
motor_mh_y2 = 19.8;
ex_mount_width = 5.0;
ex_mount_height = 3.0;

// Dimensions

// (gb = gear body)
gb_length = 37.0;
gb_width = 22.3;
gb_height = 18.6;
gb_corner_radius = 5.0;

// (mm = motor mount)
mm_length = 11.5;
mm_width = 14.6;
mm_height = 17.2;

// Shaft
shaft_dia = 5.3;
shaft_height = 9.1;
shaft_cx = 11.75; // shaft center x
shaft_cy = 11.35; // shaft center y

// Entry point
dc_motor();

module dc_motor(){
    // Draw gear box body
    color("Yellow") difference(){
        rounded_rect(gb_length + gb_corner_radius, gb_width, gb_height, gb_corner_radius);
        translate([gb_length, -ex, -ex]) 
            cube([gb_corner_radius + ex, gb_width + 2*ex, gb_height + 2*ex]);
        // Mount holes
        translate([motor_mh_x, motor_mh_y1, -ex]) cylinder(d = motor_mh_dia, h = gb_height + 2*ex);
        translate([motor_mh_x, motor_mh_y2, -ex]) cylinder(d = motor_mh_dia, h = gb_height + 2*ex);
    }
    // Draw shaft
    color("White") translate([shaft_cx, shaft_cy, gb_height])
        cylinder(d = shaft_dia, h = shaft_height);
    // Draw extra mount hole
    translate([-ex_mount_width, gb_width/2 - ex_mount_width/2, gb_height/2 - ex_mount_height/2]) 
        ex_mount();
    // Draw motor mount
    translate([gb_length, 0, 0]) color("Yellow") motor_mount();
    translate([gb_length + mm_length, 1, 1]){ 
        color("Grey") resize([8.5, gb_width - 2, mm_height - 2]) motor_mount();
        translate([8.5, 0, 0]) color("Beige") 
            resize([4.5, gb_width - 2, mm_height - 2]) motor_mount();
        translate([13, gb_width/2 -1, mm_height/2 - 1]) color("Beige") 
            rotate([0, 90, 0]) cylinder(d = 9, h = 3);
    }
}

module ex_mount(){
    color("Yellow") difference(){
        cube([ex_mount_width, ex_mount_width, ex_mount_height]);
        translate([ex_mount_width/2, ex_mount_width/2, -ex])
            cylinder(d = motor_mh_dia, h = ex_mount_height + 2*ex);
    }
}

module motor_mount(){
    difference(){
        translate([0, gb_width/2, mm_height/2]) rotate([0, 90, 0]) 
            cylinder(d = gb_width, h = mm_length);
        translate([-ex, 0, mm_height]) cube([mm_length + 2*ex, gb_width, 10]);
        translate([-ex, 0, -10]) cube([mm_length + 2*ex, gb_width, 10]);
    }
}