$fn=100;

use <Torus.scad>
lm_L = 29;
lm_D = 19;
lm_d = 10;
lm_W = 1.3;
lm_D1 = 18;
lm_B = 22;

module LM10UU()
{
    rotate([90,0,0])
        difference()
        {
            translate([0,0,lm_L/-2])
                color("gainsboro")
                    cylinder(d=lm_D,h=lm_L);
            for(i=[-1,1])
                translate([0,0,(lm_B-lm_W)/2 * i])
                    color([0.2,0.2,0.2])
                        torus(R1=lm_W/2,R2=(lm_D1+lm_W)/2);
            for(i=[0,1])
                mirror([0,0,i])
                    translate([0,0,lm_L/-2 -0.001])
                            color([0.2,0.2,0.2])
                                cylinder(d=lm_D1,h=lm_W/2);
            translate([0,0,lm_L/-2 -0.001])
                    color([0.2,0.2,0.2])
                        cylinder(d=lm_d,h=lm_L+0.002);
        }
}

LM10UU();