// Autotron Pi Zero chassis

// 3D models of the parts we have to mount on the chassis
use <rpi_zero_w.scad>;
use <L298_motor_driver.scad>;
use <pi_cam.scad>;
use <powerbank.scad>;
use <dc_motor.scad>;

test();

module test(){
    rpi_zero_w();
    translate([0, 50, 0]) L298_motor_driver();
    translate([0, 125, 0]) pi_cam();
    translate([150, 0, 0]) rotate([0,0,90]) powerbank();
    translate([80, 125, 0]) dc_motor();
    translate([80, 150, 0]) dc_motor();
}
