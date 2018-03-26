// A library of common modules, functions and variables

// Extra dimension to remove ambiguity of walls
ex = 0.001;

// Draws a rounded rectangle
module rounded_rect(x, y, z, radius = 1) {
    translate([radius,radius,0]) //move origin to outer limits
	linear_extrude(height=z)
		minkowski() {
			square([x-2*radius,y-2*radius]); //keep outer dimensions given by x and y
			circle(r = radius, $fn=100);
		}
}

// Draws quarter of a cylinder
module cylinder_quarter(r, h){
    difference(){
        cylinder(r=r, h=h);
        translate ([-r-ex, -r-ex, -ex]) cube([2*r + 2*ex, r + ex, h + 2*ex]);
        translate ([-r-ex, -ex, -ex]) cube([r + ex, r + ex, h + 2*ex]);
    }
}