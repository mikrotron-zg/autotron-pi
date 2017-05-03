// autotron Pi mountovi

// opće konstante
r_hole=3.5/2;

// power bank

// dimenzije
pb_w=79.2;
pb_l=110.14;
pb_h=21.25;
pb_d=3;
pb_sup=5;
pb_holder_l=15;
pb_holder_h_back=5;
pb_save_r=30;
// mount rupe
pb_mount_l=65.75;
pb_mount_w_front=47.02;
pb_mount_w_back=53.85;
pb_mount_l_displace=18;

// kontrola motora

// dimenzije
moto_a=50;
moto_b=55.1;
moto_hole_a=40;
moto_hole_b=45;
pind=3;
pinh=3;
flatw=55;
flath=2;
grab_l=3;
grab_h=16;

// RPi

// dimenzije
rpi_l=56.06;
rpi_w=85.05;
rpi_d=2.5;
rpi_r_l=20;
rpi_f_l1=5;
rpi_f_s2=16.3;
rpi_f_l2=5;
rpi_f_s3=41;
rpi_f_l3=7;
rpi_f_l4=25;
// mount
rpi_hole_l=43.2;
rpi_hole_w=44.5;
rpi_holder_h=8;

//cam

//dimenzije
cam_l=1.75;
cam_w=25;
cam_h=23.85;
cam_r=7.5/2;
cam_s_r=2.5/2;
//mount
cam_holder_h=10;
cam_holder_grab=2;
cam_holder_d=2;
cam_hole_w=14;

//[x,y,z]

//color([255,0,0,100])powerbank();
//translate([-pb_d,-pb_d,-pb_d])pb();
//powershield();
//RPi();
translate([-10,0,0])cam_base();
cam_hold();

module cam_hold(){
    difference(){
        union(){
            cube([cam_h,cam_w+2*cam_holder_d,flath],false);
            cube([cam_h+flath*2+r_hole*2,cam_holder_d,flath+cam_holder_h/2],false);
            translate([0,cam_w+cam_holder_d,0])cube([cam_h+flath*2+r_hole*2,cam_holder_d,flath+cam_holder_h/2],false);
        }
        translate([cam_h+flath*2,0,flath+r_hole])rotate([90,0,0])cylinder(200,r_hole,r_hole,true,$fn=32);
        translate([cam_h/2-2,cam_w/2+cam_holder_d,0])cylinder(20,cam_r,cam_r,true,$fn=32);
        translate([cam_h/2-2,cam_w+cam_holder_d-flath,0])cylinder(20,cam_s_r,cam_s_r,true,$fn=32);
        translate([cam_h/2-2,cam_holder_d+flath,0])cylinder(20,cam_s_r,cam_s_r,true,$fn=32);
    }
}

module cam_base(){
    difference(){
    union(){
        cube([cam_l+2*cam_holder_d,cam_w+2*cam_holder_d,flath],false);
        difference(){
            translate([0,cam_holder_d+cam_w/2,0])cylinder(flath,cam_holder_d+cam_w/2,cam_holder_d+cam_w/2,false,$fn=32);
            translate([0.01,0,-1])cube([50,cam_w+2*cam_holder_d,flath+2],false);
            translate([-3,cam_w/2+cam_holder_d-cam_hole_w/2,-1])cylinder(flath+2,r_hole,r_hole,false,$fn=32);
            translate([-3,cam_w/2+cam_holder_d+cam_hole_w/2,-1])cylinder(flath+2,r_hole,r_hole,false,$fn=32);
        }
        translate([0,cam_holder_d,0])cube([2*cam_holder_d+cam_l,cam_holder_d,cam_holder_h+flath-0.01],false);
        translate([0,cam_w,0])cube([2*cam_holder_d+cam_l,cam_holder_d,cam_holder_h+flath-0.01],false);
        translate([0,cam_holder_d,0]) cube([2*cam_holder_d+cam_l,cam_w,flath+3]);
    }
    translate([cam_l/2+cam_holder_d,0,cam_holder_h*4/5])rotate([90,0,0])cylinder(200,r_hole,r_hole,true,$fn=32);
    }
}

module RPi(){
    union(){
        difference(){
            cube([rpi_l+2*rpi_d,rpi_w+2*rpi_d,rpi_d],false);
            translate([rpi_l/2+rpi_d-rpi_hole_l/2,rpi_w/2+rpi_d,-1])cylinder(rpi_d+2,r_hole,r_hole,false,$fn=32);
            translate([rpi_l/2+rpi_d+rpi_hole_l/2,rpi_w/2+rpi_d+rpi_hole_w/2,-1])cylinder(rpi_d+2,r_hole,r_hole,false,$fn=32);
            translate([rpi_l/2+rpi_d+rpi_hole_l/2,rpi_w/2+rpi_d-rpi_hole_w/2,-1])cylinder(rpi_d+2,r_hole,r_hole,false,$fn=32);
            translate([rpi_l/2+rpi_d,rpi_w/2+rpi_d,-1])cube([30,60,10],true);
        }
        translate([0,0,rpi_d-0.5])cube([rpi_d,rpi_w+2*rpi_d,rpi_holder_h],false);
        translate([0,0,rpi_d-0.5])cube([rpi_r_l,rpi_d,rpi_holder_h],false);
        translate([2*rpi_d+rpi_l-rpi_r_l,0,rpi_d-0.5])cube([rpi_r_l,rpi_d,rpi_holder_h],false);
        translate([rpi_d+rpi_l,rpi_d,rpi_d-0.5])cube([rpi_d,rpi_f_l1,rpi_holder_h],false);
        translate([rpi_d+rpi_l,rpi_d+rpi_f_s2,rpi_d-0.5])cube([rpi_d,rpi_f_l2,rpi_holder_h],false);
        translate([rpi_d+rpi_l,rpi_d+rpi_f_s3,rpi_d-0.5])cube([rpi_d,rpi_f_l3,rpi_holder_h],false);
        translate([rpi_d+rpi_l,2*rpi_d+rpi_w-rpi_f_l4,rpi_d-0.5])cube([rpi_d,rpi_f_l4,rpi_holder_h],false);
    }
}

module powershield(){
    union(){
        difference(){
            union(){
                cube([moto_a,moto_b,flath],false);
                translate([moto_a/2-2*pb_d-pb_w/2,moto_b/2-pb_holder_l/2-grab_l,0]){
                    cube([4*pb_d+pb_w,pb_holder_l,flath],false);
                    cube([pb_d,pb_holder_l,grab_h+flath],false);
                    translate([pb_w+3*pb_d,0,0])cube([pb_d,pb_holder_l,grab_h+flath],false);
                }
            }
            translate([moto_a/2,moto_b/2,flath/2])cylinder(flath+2,20,20,true,$fn=32);
            pinovi(4,pind/2,[moto_a/2-moto_hole_a/2,moto_b/2-moto_hole_b/2,-1],pinh);
        }
    }
}

module powerbank(){
    cube([pb_l,pb_w,pb_h],false);
}

module pb(){
    union(){
        // glavna ploca
        difference(){
            cube([pb_l+2*pb_d,pb_w+2*pb_d,pb_d],false);
            translate([pb_d+pb_l/2,pb_d+pb_w/2,-1])cylinder(pb_d+2,pb_save_r,pb_save_r,false);
            // mount rupe
            translate([pb_l+pb_d-pb_mount_l_displace,pb_d+pb_w/2,0]){
                translate([-pb_mount_l,pb_mount_w_back/2,-1])cylinder(pb_d+2,r_hole,r_hole,false);
                translate([-pb_mount_l,-pb_mount_w_back/2,-1])cylinder(pb_d+2,r_hole,r_hole,false);
                translate([0,pb_mount_w_front/2,-1])cylinder(pb_d+2,r_hole,r_hole,false);
                translate([0,-pb_mount_w_front/2,-1])cylinder(pb_d+2,r_hole,r_hole,false);
            }
        }
        // drzaci
        pb_drzac();
        translate([pb_l/2+pb_d-pb_holder_l/2,0,0])pb_drzac();
        translate([pb_l+2*pb_d-pb_holder_l,0,0])pb_drzac();
        translate([pb_l+2*pb_d,pb_w+pb_d*2,0])rotate([0,0,180]){
            pb_drzac();
            translate([pb_l/2+pb_d-pb_holder_l/2,0,0])pb_drzac();
            translate([pb_l+2*pb_d-pb_holder_l,0,0])pb_drzac();
        }
        translate([0,pb_w/2+pb_d-pb_holder_l/2,0])cube([pb_d,pb_holder_l,pb_d+pb_holder_h_back],false);
        translate([pb_l+pb_d,pb_w/2+pb_d-pb_holder_l/2,0])cube([pb_d,pb_holder_l,pb_d+pb_h/2],false);
    }
}

module pb_drzac(){
        cube([pb_holder_l,pb_d,pb_h+2*pb_d],false);
        difference(){
            cube([pb_holder_l,pb_sup+pb_d,pb_sup+pb_d],false);
            translate([-1,pb_sup+pb_d,pb_sup+pb_d])rotate([0,90,0])cylinder(pb_holder_l+2,pb_sup,pb_sup,false,$fn=30);
        }
}

module pinovi(lift,pinr,off,pinh){
    
    startpinr=2.5*pinr;
    endpinr=2*pinr;
    pin1=[0,0,0];
    pin2=[moto_hole_a,0,0];
    pin3=[0,moto_hole_b,0];
    pin4=[moto_hole_a,moto_hole_b,0];
    
    translate(off){
        translate(pin1){
            union(){
                //cylinder(lift,startpinr,endpinr,false,$fn=20);
                cylinder(lift+pinh,pinr,pinr,false,$fn=20);
            }
        }
        translate(pin2){
            union(){
                //cylinder(lift,startpinr,endpinr,false,$fn=20);
                cylinder(lift+pinh,pinr,pinr,false,$fn=20);
            }
        }
        translate(pin3){
            union(){
                //cylinder(lift,startpinr,endpinr,false,$fn=20);
                cylinder(lift+pinh,pinr,pinr,false,$fn=20);
            }
        }
        translate(pin4){
            union(){
                //cylinder(lift,startpinr,endpinr,false,$fn=20);
                cylinder(lift+pinh,pinr,pinr,false,$fn=20);
            }
        }
    }
}