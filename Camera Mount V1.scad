// By Lucas Gelfond
// Credit for Mount Module goes to YouMagine user fns720.
// https://www.youmagine.com/designs/camera-diver-s-handle#!design-documents
// Licensed Under CC-BY-SA



//Variables
    mountXSize = 36;
    mountYSize = 46;
    mountZSize = 6;
    plateSize = 55;
    plateThick = 2;
    holePattern = 45;
    screwHole =4.5;

module cameraMount() {

	middleRailXSize = 4.5;
	middleRailYSize = 34;
	middleRailZSize = 3.5;
	
	edgeXSize = 4;
	edgeYSize = 25.75;
	edgeZSize = 4.5;

	edgeTopXSize = 7;
	edgeTopYSize = edgeYSize;
	edgeTopZSize = 2.5;

	edgeInnerAngle = 45;
	edgeOuterAngle = 25;
	edgeSideAngle = 45;
	edgeSideChamferSize = 2;

	union() {

		cube(size=[mountXSize,mountYSize,mountZSize]); // base

		translate([(mountXSize-middleRailXSize)/2, (mountYSize-mountXSize)/2, middleRailZSize]) cube(size=[middleRailXSize, middleRailYSize, middleRailZSize]); // middle rail

		difference() { // left socket
			union() {
				translate([0, (mountYSize - edgeYSize) / 2, mountZSize]) cube(size=[edgeXSize, edgeYSize, edgeZSize]); // left edge
			
				difference() {
				  translate([0, (mountYSize - edgeYSize) / 2, mountZSize + edgeZSize]) cube(size=[edgeTopXSize, edgeTopYSize, edgeTopZSize]); // left top
					translate([edgeXSize, (mountYSize - edgeYSize) / 2, mountZSize - 1]) rotate([0, 0, -edgeInnerAngle]) cube(edgeZSize + edgeTopZSize + 2); // lower right mountYSize degree trim
					translate([edgeXSize, (mountYSize - edgeYSize) / 2 + edgeYSize, mountZSize - 1]) rotate([0, 0, -edgeInnerAngle]) cube(edgeZSize + edgeTopZSize + 2); // upper right mountYSize degree trim
				}	
			}
			translate([edgeXSize, (mountYSize - edgeYSize) / 2, mountZSize - 1]) rotate([0,0,180 - edgeOuterAngle]) cube(edgeZSize + edgeTopZSize + 2); // lower left 30 degree trim
			translate([edgeXSize, (mountYSize - edgeYSize) / 2 + edgeYSize, mountZSize - 1]) rotate([0, 0, 90 + edgeOuterAngle]) cube(edgeZSize + edgeTopZSize + 2); // upper left 30 degree trim
			translate([0 + edgeSideChamferSize,  (mountYSize - edgeYSize) / 2, mountZSize + edgeZSize + edgeTopZSize]) rotate([0, -90-edgeSideAngle, 0]) cube(size=[edgeXSize, edgeYSize, edgeZSize]); // left edge side chamfer trim
		}

		difference() { // right socket
			union() {
				translate([mountXSize - edgeXSize, (mountYSize - edgeYSize) / 2, mountZSize]) cube(size=[edgeXSize, edgeYSize, edgeZSize]); // right edge
			  
			  difference() {
			  	translate([mountXSize - edgeTopXSize, (mountYSize - edgeTopYSize) / 2, mountZSize + edgeZSize]) cube(size=[edgeTopXSize, edgeTopYSize, edgeTopZSize]); // right top
					translate([mountXSize - edgeXSize , (mountYSize - edgeYSize) / 2, mountZSize - 1]) rotate([0, 0, 90 + edgeInnerAngle]) cube(edgeZSize + edgeTopZSize + 2); // lower right mountYSize degree trim
					translate([mountXSize - edgeXSize , (mountYSize - edgeYSize) / 2 + edgeYSize, mountZSize - 1]) rotate([0,0,90 + edgeInnerAngle]) cube(edgeZSize + edgeTopZSize + 2); // upper right mountYSize degree trim
				}
			}
			translate([mountXSize - edgeXSize , (mountYSize - edgeYSize) / 2, mountZSize - 1]) rotate([0,0, -90 +edgeOuterAngle]) cube(edgeZSize + edgeTopZSize + 2); // upper right 30 degree trim
			translate([mountXSize - edgeXSize, (mountYSize - edgeYSize) / 2 + edgeYSize, mountZSize - 1]) rotate([0,0,-edgeOuterAngle]) cube(edgeZSize + edgeTopZSize + 2); // lower right 30 degree trim
			translate([mountXSize - edgeSideChamferSize,  (mountYSize - edgeYSize) / 2, mountZSize + edgeZSize + edgeTopZSize]) rotate([0, edgeSideAngle, 0]) cube(size=[edgeXSize, edgeYSize, edgeZSize]); // left edge side chamfer trim
		}
	}

}
module cameraMount2() {
    difference() {
        cameraMount();
        translate([-1,-1, -1]) {
            cube([mountXSize+2, mountYSize+2, mountZSize+1]);
        }
    }
}
module mainPlate() {
    translate([mountXSize/-2-3.5, mountYSize/-2-3.5, -mountZSize]) {
        difference(){
            scale([1.2, 1.2, 1.2]) {
                cameraMount2();
            }
            translate([-1,-1,-1]) {
                cube([mountXSize*1.15+2, mountYSize*1.15+2, 0]);
           }
        }
    }
    cube([plateSize, plateSize, plateThick], center=true);
}

module screw() {
    cylinder(r=screwHole/2, h=plateThick*4, center=true, $fn=35);
}
 
module finalPlate() {
    difference() {
        mainPlate();
        translate([holePattern/2,holePattern/2,0]) {
            screw();
        }
        translate([holePattern/-2,holePattern/-2,0]) {
            screw();
        }
        translate([holePattern/-2,holePattern/2,0]) {
            screw();
        }
        translate([holePattern/2,holePattern/-2,0]) {
            screw();
        }
    }
}


finalPlate();
