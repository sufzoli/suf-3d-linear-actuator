module torus(R1,R2)
{
    rotate_extrude(convexity = 10, $fn = 144)
        translate([R2, 0, 0])
            circle(r = R1, $fn = 144);
}