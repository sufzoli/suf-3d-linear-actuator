$fn=100;
include <lib\GT2_gears.scad>
include <lib\Nema17.scad>

use <linear_bearing_holder.scad>

rod_dia=8;
rod_distance=45;
rod_len=200;

// GT2_Gear_NoTeeth();

translate([0,rod_distance/-2,10])
    color("silver")
        rotate([0,90,0])
            cylinder(d=rod_dia,h=rod_len);
translate([0,rod_distance/2,10])
    color("silver")
        rotate([0,90,0])
            cylinder(d=rod_dia,h=rod_len);            
            
nema17();            

translate([0,0,21])
    rotate([180,0,0])
        GT2_Pulley_20T();

translate([rod_len,0,5])        
    GT2_Gear_NoTeeth();        
    
// Gear holder block    
translate([rod_len-20,0,0])
{
    difference()
    {
        translate([0,-30,0])
            cube([40,60,10]);
        translate([-0.001,-11,4.5])
            cube([40.002,22,5.501]);
        translate([20,0,-0.001])
            cylinder(d=3.5,h=20.002);

        for(i=[-1,1])
        {
            for(j=[-1,1])
                translate([20-(15*j),-15*i,-0.001])
                    cylinder(d=3.5,h=20.002);
            translate([-0.001,rod_distance*0.5*i,10])
            {
                rotate([0,90,0])
                {
                    cylinder(d=4.5,h=40.002);
                    cylinder(d=8.5,h=20.001);
                    translate([0,0,20])
                        cylinder(d=9.3,h=4,$fn=6);
                }
            }
        }
    }
}

// Nema holder block

difference()
{
    translate([-25,-30,0])
        cube([50,60,20]);
    translate([0,0,-0.001])
        cylinder(d=23,h=20.002);
    translate([0,-10,3])
        cube([25.001,20,17.001]);
    for(i=[0:3])
    {
        rotate([0, 0, 90*i])
            translate([15.5, 15.5, -0.001])
                cylinder(h=20.002, d=3.5);
    }
    for(i=[-1,1])
        translate([-0.001,rod_distance*0.5*i,10])
            rotate([0,90,0])
                cylinder(d=8.5,h=25.001);
}

// gantry plate
translate([rod_len/2,0,0])
{
    translate([-40,-40,24])
        cube([80,80,8]);
    translate([0,rod_distance/2,10])
        rotate([0,0,90])
            singleLinearBearingHolder();
}