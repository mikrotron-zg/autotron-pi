// A library of common modules, functions and variables

// Extra dimension to remove ambiguity of walls
ex = 0.001;

// Hole dimension correction - if 3D printed holes turn out too small,
// increase the value (e.g. 1.1 = 110%), or reduce the value (e.g. 0.9 = 90%).
// Default value is 1.0 (100%)
hdc = 1.0;

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

//Draws 2.54 mm male header pins
module header_pin(rows=1, columns=1){
    base_width = 2.54;
    base_height = 2.54;
    header_width = 0.508;
    header_height = 5.08;
    trans = base_width/2 - header_width/2;

    for (i = [0: rows - 1]){
        for (j = [0: columns -1]){
            translate([j*base_width, i*base_width, 0]){
                color("Black") cube([base_width, base_width, base_height]);
                translate([trans , trans, base_height])
                    color("Khaki") cube([header_width, header_width, header_height]);
            }
        }
    }

}