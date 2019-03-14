// Dubs "A" class locomotive
//Measurements 1:64 scale in mm
$fs=0.5;
clearance=0.5; //why?
lengthBetweenBuffers=74;
trackGauge=16.5;
frameThickness=1.5;
frameSideHeight=10;
axleDiameter=2.0;
frameOutsideSpacing=13;//was 14 but wheels too far apart
frameInsideSpacing=frameOutsideSpacing-frameThickness*2;
echo("frame inside spacing is ",frameInsideSpacing);

bufferPlateHeight=5;
bufferPlateLength=31;

frontAxleFromFrontDistance=20;
rearAxleFromFrontDistance=47;
axleHeight=axleDiameter;
boilerCentreHeight=19;

motorLength= 15;
motorDiameter=6;
motorShaftLength=6;
motorShaftDiameter=2.0;


oringInsideDiameter=7.5;//9.5;

oringThickness=1.7;//oringOutsideDiameter-oringInsideDiameter;
oringOutsideDiameter=oringInsideDiameter+oringThickness*2;
echo("o ring OD",oringOutsideDiameter," ID is",oringInsideDiameter);

pulleyThickness=3.5;
pulleyDiameter=oringInsideDiameter+oringThickness/2*2;
echo("pulley diameter is ",pulleyDiameter);


frictionWheelDiameter=oringOutsideDiameter;
frictionWheelThickness=pulleyThickness;
frictionWheelX=frictionWheelDiameter/2+motorShaftDiameter/2;
echo("friction wheel X position is ",frictionWheelX);


driveShaftDiameter=2.0;


wormGearLength=8;
wormGearDiameter=6;

gearDiameter=12;
gearThickness=2;



motorMountThickness=2;
motorMountLength=motorLength+motorShaftLength+motorMountThickness+2;
frameIntersection=9;
motorMountDepth=frameInsideSpacing;
driveShaftLength=motorMountLength+motorMountThickness+1;

wheelRimOutsideDiameter=12;
wheelRimInsideDiameter=10;
wheelFlangeDiameter=14;//was 15 too big
wheelNumberSpokes=14;
wheelSpokeThickness=0.8;
wheelTreadThickness=3;
wheelFlangeThickness=1; //consider reducing to 0.75
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
        //axle hole
                cylinder(h=wheelTreadThickness+0.1 ,d=2 ,center=true);
    
        
    }
}
}

//!spokes();

module wheelRim() {
  difference() {
        cylinder(h=wheelTreadThickness,d=wheelRimOutsideDiameter,center=true );  
      cylinder(h=wheelTreadThickness+0.1,d=wheelRimInsideDiameter,center=true ); 
  }
}

//!wheelRim();

module wheelFlange() {
     difference() {
         cylinder(h=wheelFlangeThickness,d=wheelFlangeDiameter,center=true);
        cylinder(h=wheelTreadThickness+0.1,d=wheelRimInsideDiameter,center=true ); 
     }
}

module wheelHub() {
      difference() {
        cylinder(h=wheelTreadThickness,d=wheelHubDiameter,center=true);
        cylinder(h=wheelTreadThickness+0.1 ,d=2 ,center=true);
    }
}



module wheel() {
    translate([0,0,wheelTreadThickness/2]) wheelRim();
    translate([0,0,wheelFlangeThickness/2]) wheelFlange();
   translate([0,0,wheelTreadThickness/2]) spokes();
     translate([0,0,wheelTreadThickness/2])  wheelHub();
}

//!wheel();



module oring(oringOutsideDiameter,oringThickness) { 
    color("black") 
    rotate_extrude()
translate([(oringOutsideDiameter-(oringOutsideDiameter-oringInsideDiameter)/2)/2,0, 0])
circle(d = oringThickness); 
}

//!oring();

module pulley(diameter) {
      difference() {
          union() {
          cylinder(h=pulleyThickness,d=diameter); 
          translate([0,driveShaftDiameter/2+0.5,pulleyThickness]) linear_extrude(0.5) text(text=str(diameter),size=1.5,halign="center");
          }
         union() {
             //groove
             translate([0,0,pulleyThickness/2]) oring(diameter-1,2);
             driveShaft();
         }
}
}

!pulley(pulleyDiameter);

module pulleySet() {
    listDiameters=[7.5,8,8.5];
    for (i=[0:2]) {
        translate([i*10,0,0]) pulley(listDiameters[i]);
    }
}

//!pulleySet();

    
module frictionWheel() {
    pulley();
    translate([0,0,pulleyThickness/2])  oring(oringOutsideDiameter,oringThickness);
}

module wheelAssembly() {
   
            translate([0,-frameOutsideSpacing/2,0])  rotate([90,90,0]) wheel();
            translate([0,(frameOutsideSpacing)/2,0]) rotate([90,90,180])   wheel();
            rotate([90,90,0]) gear();
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
    translate([0,0,-motorMountThickness]) cube([frictionWheelX+motorDiameter/2+driveShaftDiameter+frameIntersection,motorMountDepth,motorMountThickness]);
    //friction Wheel end
    translate([0,0,motorMountLength-motorMountThickness]) cube([frictionWheelX+motorDiameter/2+driveShaftDiameter+frameIntersection,motorMountDepth,motorMountThickness]);
    //motor housing
    motorMountMotorHousingDepth=motorDiameter+motorMountThickness*2;
    translate([motorMountThickness,motorMountDepth/2-motorMountMotorHousingDepth/2,0]) cube([motorDiameter/1.4,motorMountMotorHousingDepth,motorLength]);
     //motor housing stops
               translate([0,motorDiameter/2-motorMountThickness-0.5,motorLength]) cube([motorDiameter,motorMountThickness+motorDiameter/3,1]);
                              translate([0,motorMountDepth-motorDiameter/2-motorMountThickness+0.5,motorLength]) cube([motorDiameter,motorMountThickness+motorDiameter/3,1]);
           }
           union() {
              //space for motor body
               translate([motorMountThickness,motorMountDepth/2-motorDiameter/2,0]) cube([motorDiameter+clearance,motorDiameter+clearance,motorLength+0.1]);
               //hole for pressure screww
            translate([-motorMountThickness/2,motorMountDepth/2,motorLength-3]) rotate([0,90,0])  cylinder(h=motorMountThickness+3,d=2.0);
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

    translate([frictionWheelX,0,-wormGearLength-3]) wormGear();
    translate([-motorDiameter/2-motorMountThickness,-motorMountDepth/2,0]) motorMount();
    motor();
       }
       union() {

       }
   }
}

//!motorAssembly();

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

module superstructure() {
    translate([boilerDistance,0,boilerDiameter/2+frameSideHeight+basePlateThickness]) boiler();
    translate([0,-basePlateWidth/2,frameSideHeight]) basePlate();
}

module loco() {

            frame();
            translate(frontWheelPosition) wheelAssembly();
            translate(rearWheelPosition) wheelAssembly();
            translate([-7,0,+14]) translate(rearWheelPosition) rotate([0,90,180])  motorAssembly();
            #superstructure();
                      
 
  
}
    
    loco();