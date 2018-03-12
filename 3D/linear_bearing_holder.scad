
$fn=100;

Y_linearBearingModel = "LM8UU";
axes_Ysmooth_rodD = 8.5;
workbed_separation_from_Y_smooth_rod = 10;
Y_singleLinearBearingHolder_screwSize = 3;
PCBholder_height = 10;
color_movingPart = "orange";
LinearBearingPressureFitTolerance = 0.4;
workbed_thickness = 8+3;

LINEAR_BEARING_dr = 0;  //Inscribed circle
LINEAR_BEARING_D  = 1;  //Outer diameter
LINEAR_BEARING_L  = 2;  //Length
LINEAR_BEARING_B  = 3;  //Outer locking groove B
LINEAR_BEARING_D1 = 4;  //Outer locking groove D1
LINEAR_BEARING_W  = 5;  //W


// Common bearing names
LinearBearing = "LM8UU";

// Linear Bearing dimensions
//  model == "XXXXX"   ?   [    dr,      D,      L,        B,      D1,       W]:
function linearBearingDimensions(model) =
    model == "LM3UU"   ?   [  3,   7,  10,   0.0,   0.0, 0.00]:
    model == "LM4UU"   ?   [  4,   8,  12,   0.0,   0.0, 0.00]:
    model == "LM5UU"   ?   [  5,  10,  15,  10.2,   9.6, 1.10]:
    model == "LM6UU"   ?   [  6,  12,  19,  13.5,  11.5, 1.10]:
    model == "LM8SUU"  ?   [  8,  15,  17,  11.5,  14.3, 1.10]:
    model == "LM10UU"  ?   [ 10,  19,  29,  22.0,  18.0, 1.30]:
    model == "LM12UU"  ?   [ 12,  21,  30,  23.0,  20.0, 1.30]:
    model == "LM13UU"  ?   [ 13,  23,  32,  23.0,  22.0, 1.30]:
    model == "LM16UU"  ?   [ 16,  28,  37,  26.5,  27.0, 1.60]:
    model == "LM20UU"  ?   [ 20,  32,  42,  30.5,  30.5, 1.60]:
    model == "LM25UU"  ?   [ 25,  40,  59,  41.0,  38.0, 1.85]:
    model == "LM30UU"  ?   [ 30,  45,  64,  44.5,  43.0, 1.85]:
    model == "LM35UU"  ?   [ 35,  52,  70,  49.5,  49.0, 2.10]:
    model == "LM40UU"  ?   [ 40,  60,  80,  60.5,  57.0, 2.10]:
    model == "LM50UU"  ?   [ 50,  80, 100,  74.0,  76.5, 2.60]:
    model == "LM60UU"  ?   [ 60,  90, 110,  85.0,  86.5, 3.15]:
    model == "LM80UU"  ?   [ 80, 120, 140, 105.5, 116.0, 4.15]:
    model == "LM100UU" ?   [100, 150, 150, 125.5, 145.0, 4.15]:
  /*model == "LM8UU"   ?*/ [  8,  15,  24,  17.5,  14.3, 1.10];


function linearBearing_dr(model) = linearBearingDimensions(model)[LINEAR_BEARING_dr];
function linearBearing_D(model)  = linearBearingDimensions(model)[LINEAR_BEARING_D];
function linearBearing_L(model)  = linearBearingDimensions(model)[LINEAR_BEARING_L];
function linearBearing_B(model)  = linearBearingDimensions(model)[LINEAR_BEARING_B];
function linearBearing_D1(model) = linearBearingDimensions(model)[LINEAR_BEARING_D1];
function linearBearing_W(model)  = linearBearingDimensions(model)[LINEAR_BEARING_W];

module linearBearing(pos=[0,0,0], angle=[0,0,0], model=LinearBearing,
                material=Steel, sideMaterial=BlackPaint) {
  dr = linearBearing_dr(model);
  D  = linearBearing_D(model);
  L  = linearBearing_L(model);
  B  = linearBearing_B(model);
  D1 = linearBearing_D1(model);
  W  = linearBearing_W(model);

  innerRim = dr + (D - dr) * 0.2;
  outerRim = D - (D - dr) * 0.2;
  midSink = W/4;

  translate(pos) rotate(angle) union() {
    color(material)
      difference() {
        // Basic ring
        Ring([0,0,0], D, dr, L, material, material);

        if(W) {
          // Side shields
          Ring([0,0,-epsilon], outerRim, innerRim, L*epsilon+midSink, sideMaterial, material);
          Ring([0,0,L-midSink-epsilon], outerRim, innerRim, L*epsilon+midSink, sideMaterial, material);
          //Outer locking groove
          Ring([0,0,(L-B)/2], D+epsilon, outerRim+W/2, W, material, material);
          Ring([0,0,L-(L-B)/2], D+epsilon, outerRim+W/2, W, material, material);
        }
      }
      if(W)
        Ring([0,0,midSink], D-L*epsilon, dr+L*epsilon, L-midSink*2, sideMaterial, sideMaterial);
  }

  module Ring(pos, od, id, h, material, holeMaterial) {
    color(material) {
      translate(pos)
        difference() {
          cylinder(r=od/2, h=h);
          color(holeMaterial)
            translate([0,0,-10*epsilon])
              cylinder(r=id/2, h=h+20*epsilon);
        }
    }
  }

}

module bcube(size,cr=0,cres=0)
{
  //-- Internal cube size
  bsize = size - 2*[cr,cr,0];

  //-- Get the (x,y) coorner coordinates in the 1st cuadrant
  x = bsize[0]/2;
  y = bsize[1]/2;

  //-- A corner radius of 0 means a standar cube!
  if (cr==0)
    cube(bsize,center=true);
  else {

      
      //-- The height of minkowski object is double. So
      //-- we sould scale by 0.5
      scale([1,1,0.5])

      //-- This translation is for centering the minkowski objet
      translate([-x, -y,0])

      //-- Built the  beveled cube with minkowski
      minkowski() {

        //-- Internal cube
        cube(bsize,center=true);

        //-- Cylinder in the corner (1st cuadrant)
        translate([x,y, 0])
          cylinder(r=cr, h=bsize[2],center=true, $fn=4*(cres+1));
      }
  }

}




module linearBearingHole(model="LM8UU", lateralExtension=10, pressureFitTolerance=0.4, lengthExtension=6, holderLength=1.5, tolerance=0.1) {
	linearBearingLength = linearBearing_L(model);
	linearBearingDiameter = linearBearing_D(model);
	
	dimY = linearBearingLength+lengthExtension;
	
	// Hole for linear bearing
	translate([0,linearBearingLength/2,0])
		rotate([90,0,0])
		translate([0,0,-tolerance])
			cylinder(r=linearBearingDiameter/2+tolerance, h=linearBearingLength+2*tolerance);
	// Slot for inserting the bearing
	translate([0,0,-lateralExtension/2])
		cube([linearBearingDiameter-pressureFitTolerance*2,dimY+0.01,lateralExtension+0.01], center=true);
	// Plastic holders to keep the bearing in place
	translate([0,linearBearingLength/2,0])
		hull() {
			translate([0,holderLength,0])
				rotate([90,0,0]) cylinder(r=linearBearingDiameter/2-pressureFitTolerance, h=0.01, center=true);
			rotate([90,0,0]) cylinder(r=linearBearingDiameter/2, h=0.01, center=true);
		}
	scale([1,-1,1]) translate([0,linearBearingLength/2,0])
		hull() {
			translate([0,holderLength,0])
				rotate([90,0,0]) cylinder(r=linearBearingDiameter/2-pressureFitTolerance, h=0.01, center=true);
			rotate([90,0,0]) cylinder(r=linearBearingDiameter/2, h=0.01, center=true);
		}
	rotate([90,0,0]) cylinder(r=linearBearingDiameter/2-pressureFitTolerance, h=dimY+1, center=true);//linearBearingHole(model=linearBearingModel, renderPart=true);
}
/*
module linearBearing_single(model="LM8UU", renderPart=false, echoPart=false) {
	renderStandardPart(renderPart)
		linearBearing(model=model);
	if(echoPart) echo(str("BOM: Linear bearing. Model ", model));
}
*/

module singleLinearBearingHolder()
{
	linearBearingLength = linearBearing_L(Y_linearBearingModel);
	linearBearingDiameter = linearBearing_D(Y_linearBearingModel);
	
	plasticHolderLength = 3;
	
	dimX = linearBearingDiameter+linearBearingDiameter/2;
	dimY = linearBearingLength+2*plasticHolderLength;
	dimZ = workbed_separation_from_Y_smooth_rod+axes_Ysmooth_rodD/2;
	
	holderExtension = linearBearingDiameter/3;
	
	screwSize = Y_singleLinearBearingHolder_screwSize;
	
	footSeparation = screwSize*2;
	footThickness = 5;
	
	workbed_screws_aditional_length = PCBholder_height;

		difference() {
			// Main part
			color(color_movingPart) union() {
                
				translate([0,0,dimZ/2])
					bcube([dimX,dimY,dimZ], cr=3, cres=0);
				translate([0,0,dimZ])
					hull() {
//						translate([screwSize/2,0,-footThickness/2])
						translate([0,0,-footThickness/2])
							bcube([dimX+20,dimY,footThickness], cr=3, cres=0);
                        /*
						translate([dimX/2+footSeparation,0,-footThickness/2])
							cylinder(r=screwSize+3,h=footThickness,center=true); */
					}
				translate([0,0,-holderExtension/2])
					bcube([dimX,dimY,holderExtension], cr=3, cres=0);
			}
			// Hole for linear bearing
			linearBearingHole(model=Y_linearBearingModel, lateralExtension=holderExtension, pressureFitTolerance=LinearBearingPressureFitTolerance, lengthExtension=2*plasticHolderLength, holderLength=plasticHolderLength/2);
			// Slot for zip-tie
			rotate([90,0,0]) difference() {
				cylinder(r=dimX/2+2,h=4,center=true);
				cylinder(r=dimX/2,h=4+0.1,center=true);
			}
		}
}


singleLinearBearingHolder();