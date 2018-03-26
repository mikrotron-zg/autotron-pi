// Simplified 3D model of RealPower PB-6k powerbank

include <common.scad>; // Include the common library

// Defines smoothness of rounded objects
$fn = 80;

// Powerbank's outer dimensions
pb_length = 101.0;
pb_width = 62.5;
pb_height = 22.3;

// Bevel radius
pb_rvert = 9.0;
pb_rhor = 6.0;

// USB connectors
usb_out_width = 12.0;
usb_out_height = 5.0;
usb_in_width = 7.0;
usb_in_height = 2.0;
usb_inset = 2.0;

// Lights
light_radius = 2.5;
light_extrude = 1.0;
led_radius = 0.3;
led_distance = 3.0;

// On/Off button
oo_btn_width = 10;
oo_btn_height = 4;
oo_btn_extrude = 0.2;

// Entry point
powerbank();

module powerbank(){
    difference(){
        // Draw body
        color ("Gray") pb_body();
        // Draw USB connectors
        translate ([pb_length - usb_inset + ex , 8.5, 7.5]) 
            color("Orange") cube([usb_inset, usb_out_width, usb_out_height]);
        translate ([pb_length - usb_inset + ex , pb_width - 8.5 - usb_out_width, 7.5]) 
            color("Green") cube([usb_inset, usb_out_width, usb_out_height]);
        translate ([pb_length - usb_inset + ex , pb_width - 28 - usb_in_width, 11]) 
            color("Azure") cube([usb_inset, usb_in_width, usb_in_height]);
        // Draw status LEDs
        translate([pb_length - 3*led_distance - 12.5, pb_rvert, pb_height - 2])
            color("Blue"){
                for (i =[0:1:3]) translate([i*led_distance, 0, 0]) 
                    cylinder(r = led_radius, h = 2 + ex);
            }
    }
    // Draw light lens
    translate ([pb_length - light_radius/2, pb_width - 28 - usb_in_width/2, 5]) 
            color("White") sphere(r = light_radius);
    // Draw On/Off switch
    translate ([pb_length - 25, -oo_btn_extrude, pb_height/2 - oo_btn_height/2])
        rotate([90, 0, 0]) color ("DimGray") 
            rounded_rect(oo_btn_width, oo_btn_height, oo_btn_extrude, 0.5);
}

module pb_body(){
    // Draw front double (hor/vert) bevel
    intersection(){
        rounded_rect(pb_length, pb_width, pb_height, pb_rhor);
        translate ([pb_length, pb_rvert, pb_height - pb_rvert]) 
            rotate([90,0,-90]) cylinder_quarter(pb_rvert, pb_length);
    }
    intersection(){
        rounded_rect(pb_length, pb_width, pb_height, pb_rhor);
        translate ([0, pb_rvert, pb_rvert]) 
            rotate([-90,0,-90]) cylinder_quarter(pb_rvert, pb_length);
    }
    translate ([0, 0, pb_rvert]) rounded_rect(pb_length, 3*pb_rhor, pb_height - 2*pb_rvert, pb_rhor);
    
    // Draw back (vert) bevel
    translate ([0, pb_width - 3*pb_rvert, pb_height]) rotate([0, 90, 0]) rounded_rect(pb_height, 3*pb_rvert, pb_length, pb_rvert);
    
    // Middle part of the body
    translate ([0, pb_rvert, 0]) cube([pb_length, pb_width - 2*pb_rvert, pb_height]);
}