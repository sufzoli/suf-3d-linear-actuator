$fn=100;

module SHF10()
{
    color("gainsboro")
    {
        difference()
        {
            union()
            {
                cylinder(d=20,h=10);
                hull()
                {
                    cylinder(d=20,h=5);
                    for(i=[-1,1])
                        translate([16 * i,0,0])
                            cylinder(d=11,h=5);
                }
                translate([0,0,5])
                    rotate([0,90,0])
                        translate([0,-4,-7])
                            cylinder(d=20,h=14);
            }
            translate([0,0,-0.001])
                cylinder(d=10,h=10.002);
            for(i=[-1,1])
                translate([16 * i,0,-0.001])
                    cylinder(d=5.5,h=5.002);
            translate([0,0,9.999])
                cylinder(d=43.002,h=10);
            translate([0,0,-9.999])
                cylinder(d=43.002,h=10);
            rotate([0,90,0])
            {
                translate([-5,-10.5,0])
                    cylinder(d=4.5,h=7.001);
                translate([-5,-10.5,6.999])
                    cylinder(d=8,h=7.001);
            }
            translate([-0.5,-14.001,-0.001])
                cube([1,14,10.002]);
        }
    }
    // screw
    color([0.2,0.2,0.2])
    {
        rotate([0,90,0])
        {
            translate([-5,-10.5,-6])
                cylinder(d=4,h=13.001);
            difference()
            {
                translate([-5,-10.5,6.999])
                    cylinder(d=6,h=4);
                translate([-5,-10.5,8])
                    cylinder(d=4,h=3.001,$fn=6);
            }
        }
    }    
}

SHF10();

