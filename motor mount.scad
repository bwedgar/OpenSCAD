// Dubs "A" class locomotive
//Measurements 1:64 scale in mm
$fs=0.5;
clearance=0.5; //why?
lengthBetweenBuffers=74;
trackGauge=16.5;
frameThickness=1;
frameSideHeight=10;
axleDiameter=2.5;
frameOutsideSpacing=14;
frameInsideSpacing=frameOutsideSpacing-frameThickness*2;

frontAxleFromFrontDistance=20;
rearAxleFromFrontDistance=47;
axleHeight=6;
boilerCentreHeight=19;

motorLength= 15;
motorDiameter=6;
motorShaftLength=6;
motorShaftDiameter=1.5;

frictionWheelDiameter=12;
frictionWheelThickness=3;
frictionWheelORingID=12;
frictionWheelORingThickness=3;
frictionWheelX=frictionWheelDiameter/2+motorShaftDiameter/2;

driveShaftDiameter=2.5;


wormGearLength=8;
wormGearDiameter=4.6;

gearDiameter=12;
gearThickness=2;



motorMountThickness=2;
motorMountLength=motorLength+motorShaftLength+motorMountThickness+2;
frameIntersection=6;
motorMountDepth=frameInsideSpacing;
driveShaftLength=motorMountLength+motorMountThickness+1;

wheelRimOutsideDiameter=13;
wheelRimInsideDiameter=11;
wheelFlangeDiameter=16;
wheelNumberSpokes=14;
wheelSpokeThickness=1;
wheelTreadThickness=3;
wheelFlangeThickness=2;
wheelHubDiameter=5;
wheelThickness=wheelTreadThickness+wheelFlangeThickness;

frontWheelPosition=[frontAxleFromFrontDistance,0,axleHeight];
rearWheelPosition=[rearAxleFromFrontDistance,0,axleHeight];

module gear() {
    color("white") cylinder(h=gearThickness,d=gearDiameter,center=true);
}

module axle() {
    rotate ([90,0,0])  cylinder(h=60,d=axleDiameter,center=true);
}

module wheel() {
    color("brown") cylinder(h=wheelThickness,d=14);
    }


module frictionWheel() {
    cylinder(h=frictionWheelThickness,d=frictionWheelDiameter);
}

module wheelAssembly() {
    rotate ([90,0,0]) 
        union() {
            translate([0,0,-frameOutsideSpacing]) wheel();
            translate([0,0,frameOutsideSpacing-wheelThickness]) wheel();
            gear();
    }
}

module motor() {
    color("red") cylinder(h=motorLength,d=motorDiameter);
    translate([0,0,motorLength/2+motorShaftLength]) cylinder(h=motorShaftLength,d=motorShaftDiameter);
}

module driveShaft() {
     cylinder(h=driveShaftLength,d=driveShaftDiameter);
}

module wormGear() {
    color("white")  cylinder(h=wormGearLength,d=wormGearDiameter);
}

module motorMount() {
       color("white") 
    difference() {
           union() {
    //top
    cube([motorMountThickness,motorMountDepth,motorMountLength]);
    //worm end
    translate([0,0,-motorMountThickness]) cube([frictionWheelX+motorDiameter+driveShaftDiameter+frameIntersection,motorMountDepth,motorMountThickness]);
    //friction Wheel end
    translate([0,0,motorMountLength-motorMountThickness]) cube([frictionWheelX+motorDiameter+driveShaftDiameter,motorMountDepth,motorMountThickness]);
    //motor housing
    translate([motorDiameter-motorMountThickness/2,motorMountDepth/2,motorMountThickness*3]) cube([motorDiameter+1.6,motorDiameter+2,motorLength], center=true);
           }
           union() {
              //space for motor body
               translate([motorDiameter-motorMountThickness/2+0.5,motorMountDepth/2,0]) cylinder(h=motorLength,d=motorDiameter+clearance);
               //hole for motor wires
               translate([motorDiameter-motorMountThickness/2,motorMountDepth/2,-5]) cylinder(h=motorLength,d=2.5);
               //space for inserting motor
               translate([motorDiameter,(motorDiameter-2.1)/2,0]) cube([motorDiameter+1.6,motorDiameter+2.2,motorLength]);
               //drive shaft
                             translate([frictionWheelX+motorDiameter/2+motorMountThickness,motorMountDepth/2,-2]) driveShaft(); 
           }
    }
}

//motorMount();

module motorAssembly() {
   difference() {
       union() {
           translate([frictionWheelX,0,motorLength+motorShaftLength/2-frictionWheelThickness/2]) frictionWheel();

    translate([frictionWheelX,0,0]) wormGear();
    translate([-motorDiameter/2-motorMountThickness,-motorMountDepth/2,0]) motorMount();
    motor();
       }
       union() {

       }
   }
}

//motorAssembly();

module frameSide() {
    cube([lengthBetweenBuffers,frameThickness,frameSideHeight]);
}

module frame() {
    difference() {
        union() {
            translate([0,frameInsideSpacing/2,0]) frameSide();
            translate([0,-frameOutsideSpacing/2,0]) frameSide();
            translate(frontWheelPosition) wheelAssembly();
            translate(rearWheelPosition) wheelAssembly();
            translate([5,0,+15]) translate(rearWheelPosition) rotate([0,90,180])  motorAssembly();
            
        }
        union() {
            translate(frontWheelPosition) axle();
            translate(rearWheelPosition) axle();
        }
    }
  
}
    
    frame();