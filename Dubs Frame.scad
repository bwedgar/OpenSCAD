// Dubs "A" class locomotive
//Measurements 1:64 scale in mm

lengthBetweenBuffers=74;
trackGauge=16.5;
frameThickness=1;
frameSideHeight=10;
axleDiameter=2.5;
frameSpacing=14-frameThickness/2;
frontAxleFromFrontDistance=20;
rearAxleFromFrontDistance=47;
axleHeight=6;
boilerCentreHeight=19;

motorLength= 14;
motorDiameter=6;
motorShaftLength=6;
motorShaftDiameter=1.5;

frictionWheelDiameter=12;
frictionWheelThickness=3;
frictionWheelORingID=12;
frictionWheelORingThickness=3;
frictionWheelX=frictionWheelDiameter/2+motorShaftDiameter/2;

driveShaftDiameter=2.5;


wormGearLength=12;
wormGearDiameter=6;

motorMountThickness=2;
motorMountLength=motorLength+motorShaftLength+motorMountThickness;

motorMountDepth=frameSpacing;
driveShaftLength=motorMountLength;

wheelRimOutsideDiameter=13;
wheelRimInsideDiameter=11;
wheelFlangeDiameter==16;
wheelNumberSpokes=14;
wheelSpokeThickness=1;
wheelTreadThickness=4;
wheelFlangeThickness=2;
wheelHubDiameter=5;


module wheel() {

    }


module frictionWheel() {
    cylinder(h=frictionWheelThickness,d=frictionWheelDiameter);
}

module motor() {
    color("red") cylinder(h=motorLength,d=motorDiameter);
    translate([0,0,motorLength/2+motorShaftLength]) cylinder(h=motorShaftLength,d=motorShaftDiameter);
}

module driveShaft() {
     color("yellow")  cylinder(h=driveShaftLength,d=driveShaftDiameter);
}

module wormGear() {
    color("white")  cylinder(h=wormGearLength,d=wormGearDiameter);
}

module motorMount() {
    //top
    cube([motorMountThickness,motorMountDepth,motorMountLength]);
    //worm end
    cube([frictionWheelX+motorDiameter,motorMountDepth,motorMountThickness]);
    //friction Wheel end
    translate([0,0,motorMountLength-motorMountThickness]) cube([frictionWheelX+motorDiameter,motorMountDepth,motorMountThickness]);
}

module motorAssembly() {
   difference() {
       union() {
           translate([frictionWheelX,0,motorLength+motorShaftLength/2-frictionWheelThickness/2]) frictionWheel();

    translate([frictionWheelX,0,0]) wormGear();
    translate([-motorDiameter/2-motorMountThickness,-motorMountDepth/2,0]) motorMount();
    motor();
       }
       union() {
              translate([frictionWheelX,0,0]) driveShaft(); 
       }
   }
}

motorAssembly();

module frameSide() {
    cube([lengthBetweenBuffers,frameThickness,frameSideHeight]);
}

module axle() {
    rotate ([90,0,0]) cylinder(h=30,d=axleDiameter,center=true);
}



module frame() {
    difference() {
        union() {
            translate([0,-frameSpacing/2,0]) frameSide();
            translate([0,frameSpacing/2,0]) frameSide();
        }
        union() {
            translate([frontAxleFromFrontDistance,0,axleHeight]) axle();
            translate([rearAxleFromFrontDistance,0,axleHeight]) axle();
        }
    }
}
    
    frame();