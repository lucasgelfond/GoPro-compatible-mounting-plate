// By Lucas Gelfond
// Credit for Mount Module goes to YouMagine user fns720.
// https://www.youmagine.com/designs/camera-diver-s-handle#!design-documents
// Licensed Under CC-BY-SA

//Variables
    mountX = 36;
    mountY = 46;
    mountZ = 3;
    plateSize = 55;
    plateThick = 2;
    holePattern = 45;
    screwHole =4.5;
    
    midRailX = 4.5;
	midRailY = 34;
	midRailZ = 1.75;
	
	edgeX = 4;
	edgeY = 25.75;
	edgeZ = 4.5;

	edgeHangX = 7;
	edgeHangY = edgeY;
	edgeHangZ = 2.5;
    
    //test
    railDist = 10.5;
    
	edgeInnerAngle = 45;
	edgeOuterAngle = 25;
	edgeSideAngle = 45;
    
	edgeChamferSize = 2;
    edgeChamferAngle = 30;
    
    edgeRailNum = 3;


module baseAndMid() {
    cube([mountX, mountY, mountZ], center=true); //base
    translate([0,0,(midRailZ+mountZ)/2]) cube([midRailX, midRailY, midRailZ], center=true); //middle rail
}


//credit OpenSCAD forum user tp3
module edgeRails() {
    for(i = [1,-1]) {
        translate([(railDist+(midRailX+edgeX)/2)*i,0,(edgeZ+mountZ)/2]) {
            difference() {
                cube([edgeX,edgeY,edgeZ], center=true); //edge rails
                for (n = [1, -1]) {
                     translate([0,edgeY/2*i*n,0]) rotate([0,0,30*n]) cube([edgeX*2, edgeChamferSize, edgeZ], center=true);
                }
            }
        }
    }
} 


module cameraMount2() {
    baseAndMid();
    edgeRails();
}
cameraMount2();