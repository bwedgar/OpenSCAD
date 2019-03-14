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
bufferPlateHeight=5;
bufferPlateLength=31;

frontAxleFromFrontDistance=20;
rearAxleFromFrontDistance=47;
axleHeight=axleDiameter;
boilerCentreHeight=19;

motorLength= 15;
motorDiameter=6;
motorShaftLength=6;
motorShaftDiameter=1.5;

frictionWheelDiameter=16;
frictionWheelThickness=3;
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

wheelRimOutsideDiameter=12;
wheelRimInsideDiameter=10;
wheelFlangeDiameter=15;
wheelNumberSpokes=14;
wheelSpokeThickness=0.8;
wheelTreadThickness=3;
wheelFlangeThickness=1;
wheelHubDiameter=5;
wheelThickness=wheelTreadThickness+wheelFlangeThickness;

frontWheelPosition=[frontAxleFromFrontDistance,0,axleHeight];
rearWheelPosition=[rearAxleFromFrontDistance,0,axleHeight];

boilerLength=55;
boilerDiameter=15;
boilerDistance=5;
basePlateThickness=1;
basePlateLength=lengthBetweenBuffers;
basePlateWidth=31;

module gear() {
    color("white") cylinder(h=gearThickness,d=gearDiameter,center=true);
}

module axle() {
    rotate ([90,0,0])  cylinder(h=60,d=axleDiameter,center=true);
}

module spokes() {
    difference() {
        union() {
    rotate([0,0,0-22.5]) cube([wheelRimInsideDiameter,wheelSpokeThickness,wheelTreadThickness] ,center=true);
    rotate([0,0,45-22.5]) cube([wheelRimInsideDiameter,wheelSpokeThickness,wheelTreadThickness] ,center=true);
    //balances
     for (i=[90:10:135]) { 
        rotate([0,0,i-22.5]) cube([wheelRimInsideDiameter,wheelSpokeThickness,wheelTreadThickness] ,center=true);
        }
    }
    union() {
    //pin hole
    translate([0,wheelRimOutsideDiameter/4,0]) cylinder(h=wheelTreadThickness+0.1,d=1.5 ,center=true);
      //axle Hole
        cylinder(h=wheelTreadThickness+0.1,d=2 ,center=true);
        
    }
}
}

module wheel() {
    //rim and flange
    difference() {
        union() {
        cylinder(h=wheelFlangeThickness,d=wheelFlangeDiameter );
        cylinder(h=wheelTreadThickness,d=wheelRimOutsideDiameter );
    }
              cylinder(h=wheelTreadThickness+0.1,d=wheelRimInsideDiameter );
    }
 translate([0,0,wheelFlangeThickness]) spokes();
    
    }

!wheel();
    
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
       color("yellow") 
    difference() {
           union() {
    //top
    cube([motorMountThickness,motorMountDepth,motorMountLength]);
    //worm end
    translate([0,0,-motorMountThickness]) cube([frictionWheelX+motorDiameter+driveShaftDiameter+frameIntersection,motorMountDepth,motorMountThickness]);
    //friction Wheel end
    translate([0,0,motorMountLength-motorMountThickness]) cube([frictionWheelX+motorDiameter+driveShaftDiameter+frameIntersection,motorMountDepth,motorMountThickness]);
    //motor housing
    motorMountMotorHousingDepth=motorDiameter+motorMountThickness*2;
    translate([motorMountThickness,motorMountDepth/2-motorMountMotorHousingDepth/2,0]) cube([motorDiameter/1.4,motorMountMotorHousingDepth,motorLength]);
           }
           union() {
              //space for motor body
               translate([motorMountThickness,motorMountDepth/2-motorDiameter/2,0]) cube([motorDiameter+clearance,motorDiameter+clearance,motorLength+0.2]);
               //hole for motor wires
               translate([motorDiameter-motorMountThickness/2,motorMountDepth/2,-5]) cylinder(h=motorLength,d=2.5);
               //space for inserting motor
               translate([motorDiameter,(motorDiameter-2.1)/2,0]) cube([motorDiameter+1.6,motorDiameter+2.2,motorLength]);
               //drive shaft
                             translate([frictionWheelX+motorDiameter/2+motorMountThickness,motorMountDepth/2,-2]) driveShaft(); 
           }
    }
}

//!motorMount();

module motorAssembly() {
   difference() {
       union() {
           translate([frictionWheelX,0,motorLength+motorShaftLength/2-frictionWheelThickness/2]) frictionWheel();

    translate([frictionWheelX,0,wormGearLength/2]) wormGear();
    translate([-motorDiameter/2-motorMountThickness,-motorMountDepth/2,0]) motorMount();
    motor();
       }
       union() {

       }
   }
}

//motorAssembly();

module frameSideBlock() {
    union() {
        cube([lengthBetweenBuffers,frameThickness,frameSideHeight]);
    }
}

module frameCutout() {
    intersection() {
        translate([frameSideHeight/2,frameThickness-0.1,0]) rotate([90,0,0]) cylinder(h=frameThickness*2+0.2,d=frameSideHeight);
        translate([frameSideHeight/2,-frameThickness-0.1,0]) cube([frameSideHeight/2,frameThickness*2+0.2,frameSideHeight/2]);  
    }
            translate([-4,-frameThickness-0.1,0]) cube([frameSideHeight,frameThickness*2+0.2,frameSideHeight/2]); 
}

frameCutoutLength=frameSideHeight;

//!frameCutout();



module frameSide() {
    difference() {
        union() {
    frameSideBlock();
        
        }
    union() {
    translate([frontAxleFromFrontDistance+frameCutoutLength+axleDiameter,0,0]) rotate([0,0,180]) frameCutout();
            translate([rearAxleFromFrontDistance-frameCutoutLength-axleDiameter,0.2,0])  frameCutout();
                   translate([rearAxleFromFrontDistance+frameCutoutLength+axleDiameter,0,0])  rotate([0,0,180]) frameCutout();
                    translate([rearAxleFromFrontDistance+frameCutoutLength*2+axleDiameter,0,0])   frameCutout();
    }
    }
}


module bufferPlate() {
      translate([0,0,frameSideHeight-bufferPlateHeight/2-frameThickness]) rotate([0,90,0]) {
          radius=2;
    x=bufferPlateHeight;
    y=bufferPlateLength;
    z=frameThickness;
    linear_extrude(height=z)
hull()
{

    // place 4 circles in the corners, with the given radius
    translate([(-x/2)+(radius/2), (-y/2)+(radius/2), 0])
    circle(r=radius);

    translate([(x/2)-(radius/2), (-y/2)+(radius/2), 0])
    circle(r=radius);

    translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0])
    circle(r=radius);

    translate([(x/2)-(radius/2), (y/2)-(radius/2), 0])
    circle(r=radius);
}

}
}

module frame() {
    difference() {
        union() {
                translate([0,frameInsideSpacing/2,0]) frameSide();
            translate([0,-frameOutsideSpacing/2,0]) frameSide();
    bufferPlate();
                    translate([lengthBetweenBuffers,0,0]) bufferPlate();
        }
        union() {
            translate(frontWheelPosition) axle();
            translate(rearWheelPosition) axle();

        }}
        
}

//!frame();

module boiler() {
    rotate([0,90,0]) cylinder(h=boilerLength,d=boilerDiameter);
}

module basePlate() {
    cube([lengthBetweenBuffers,bufferPlateLength,basePlateThickness]);
}

module loco() {

            frame();
            translate(frontWheelPosition) wheelAssembly();
            translate(rearWheelPosition) wheelAssembly();
            translate([8,0,+15]) translate(rearWheelPosition) rotate([0,90,180])  motorAssembly();
    translate([boilerDistance,0,boilerDiameter/2+frameSideHeight+basePlateThickness]) boiler();
    translate([0,-basePlateWidth/2,frameSideHeight]) basePlate();
                      
 
  
}
    
    loco();