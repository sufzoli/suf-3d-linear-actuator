//Quick design of a NEMA 17 (SM-42BYG011-25) motor
$fn=100;
debug = 0;

motor_height = 34.0;

module nema17()
{
    translate([0,0,motor_height*-1])
        difference()
        {
    //motor
            union(){
                translate([0,0,motor_height/2]){
                    intersection(){
                        cube([42.3,42.3,motor_height], center = true);
                        rotate([0,0,45]) translate([0,0,-1]) cube([74.3*sin(45), 73.3*sin(45) ,motor_height+2], center = true);
                    }
                }
                translate([0, 0, motor_height]) cylinder(h=2, r=11);
                translate([0, 0, motor_height+2]) cylinder(h=20, r=2.5);
            }
    //screw holes
            for(i=[0:3]){
                    rotate([0, 0, 90*i])translate([15.5, 15.5, motor_height-4.5]) cylinder(h=5, r=1.5);
                }
        }    
}