module GT2_Pulley_16T()
{
    difference()
    {
        union()
        {
            cylinder(d=13.8,h=7);
            translate([0,0,7])
                cylinder(d=9.4,h=7);
            translate([0,0,14])
                cylinder(d=13.8,h=1);
        }
        translate([0,0,-0.001])
            cylinder(d=5,h=15.002);
    }
    for(i=[0:15])
        rotate([0,0,i*22.5])
            translate([4.5,0,7])
                cube([0.6,0.92,7]);
}

module GT2_Pulley_20T()
{
    difference()
    {
        union()
        {
            cylinder(d=16,h=7.5);
            translate([0,0,7.5])
                cylinder(d=10.4,h=7);
            translate([0,0,14.5])
                cylinder(d=16,h=1.5);
        }
        translate([0,0,-0.001])
            cylinder(d=5,h=16.002);
    }
    for(i=[0:19])
        rotate([0,0,i*18])
            translate([5,0,7.5])
                cube([0.6,0.92,7]);
}


module GT2_Gear_NoTeeth()
{
    difference()
    {
        union()
        {
            cylinder(d=16,h=1.5);
            translate([0,0,1.5])
                cylinder(d=12.3,h=7);
            translate([0,0,8.5])
                cylinder(d=16,h=1.5);
        }
        translate([0,0,-0.001])
            cylinder(d=4,h=10.002);
    }
}