//linear actuator

//use <motor mount.scad>;
//use <motorVibrator.scad>;
$fn=20;
trackwheelDiameter=45;
trackwheelHeight=5;
gearwheeelDiameter=50;
gearwheelHeight=5;
caseHeight=60;
caseDepth=70;
caseThickness=5;
baseThickness=5;
caseWidth=60;
motorHeight=15;
motorDiameter=20;
motorLength=13;
motorSpindleLength=20;
barLength=70;
barWidth=5;
barHeight=5;
yokeLength=46;
yokeWidth=15;
yokeSlotLength=36;
yokeSlotWidth=5;
pinOffset=yokeSlotLength/2-3;
pinHeight=8;
motorLength=14;
motorDiameter=6;
spindleDiameter=1.5;
spindleLength=6;
LEDProbeLength=30;
LEDProbeDiameter=6;

sleeveLength=20;
sleeveOD=10;
sleeveID=8;

    motorBodyDiameter=6;
    motorBodyLength=12;
    motorSpindleLength=4;
    motorSpindleDiameter=0.75;
    
oringInsideDiameter=40.94;
oringThickness=2.62;// SAECOWILSON BS130 Nitrile
oringOutsideDiameter=oringInsideDiameter+oringThickness*2;

pulleyThickness=4;
pulleyDiameter=oringInsideDiameter+oringThickness/2;
echo("pulley diameter is ",pulleyDiameter);


module motorVibrator() {
    color("silver") union(){
        cylinder(h=motorBodyLength, d=motorBodyDiameter, center=true);
        translate([0,0,motorBodyLength/2+motorSpindleLength/2]) cylinder(h=motorSpindleLength, d=motorSpindleDiameter, center=true);
    }
}

module base() {
    difference() {
        cube([caseWidth,caseDepth,baseThickness],center=true);
        translate([0,-27,baseThickness/2]) union() {
            cylinder(h=baseThickness/2+6, d=motorBodyDiameter,center=true);
            cylinder(h=baseThickness+6, d=4,center=true);  
        }
    }
}


module back() {
        cube([caseWidth,baseThickness,caseDepth],center=true);
    }


module case() {
    union() {
       translate([0,5,0]) base();
   //translate([0,-caseDepth/2,caseHeight/2]) back();    
    }
}

module sleeve() {
    color("silver") difference() {
        cylinder(h=sleeveLength,d=sleeveOD,center=true);
        cylinder(h=sleeveLength,d=sleeveID,center=true);
}
}

translate([0,0,10]) sleeve();

module axle() {
    color("black") cylinder(h=20,d=8,center=true);
    color("black")  translate([0,0,-10]) cylinder(h=10,d=18,center=true);
}

translate([0,0,0]) axle();



module oring() { 
    color("black") 
    rotate_extrude()
translate([(oringOutsideDiameter-(oringOutsideDiameter-oringInsideDiameter)/2)/2,0, 0])
circle(d = oringThickness); 
}

//!oring();

module pulley() {
      difference() {
          union() {
          cylinder(h=pulleyThickness,d=pulleyDiameter); 
          translate([0,sleeveOD/2+0.5,pulleyThickness]) linear_extrude(0.5) text(text=str(pulleyDiameter),size=1.5,halign="center");
              translate([0,0,pulleyThickness/2])  oring();
              translate([0,0,-pulleyThickness/2]) cylinder(h=6,d=sleeveOD+6,center=true);
                    translate([pinOffset,0,-pulleyThickness]) cylinder(h=6,d=yokeSlotWidth+4);
          }
         union() {
             //groove
             translate([0,0,pulleyThickness/2]) oring(pulleyDiameter-1,2);
             cylinder(h=sleeveLength,d=sleeveOD,center=true);
             translate([pinOffset,0,-pulleyThickness/2]) cylinder(h=pinHeight,d=yokeSlotWidth-0.2);
                 
         }
}
  *translate([0,0,pulleyThickness/2])  oring();
}

!pulley();

module trackwheel() {
    union() {
        cylinder(d=trackwheelDiameter,h=trackwheelHeight,center=true);
        translate([pinOffset,0,trackwheelHeight/2]) cylinder(h=pinHeight,d=yokeSlotWidth-0.2);
    }
}

module bar() {
    color("blue") cube([barWidth,barLength,barHeight],center=true);
}

module scotchYoke() {
    color("blue") translate([0,barLength/2+4,0]) cube([barWidth,barLength,barHeight],center=true);
    difference() {
    color("blue") rotate([0,0,90]) cube([yokeWidth,yokeLength,barHeight],center=true);
    rotate([0,0,90]) cube([yokeSlotWidth,yokeSlotLength,barHeight+2],center=true);
    }
}



module sliderMount() {
    difference(){
        translate([-barWidth*3/2,25,caseThickness/2]) cube([barWidth*3,15,35]);
        
           translate([0,33,22]) cube([barWidth+0.5,18,barHeight+0.5],center=true);
}
}

sliderMount();

module LEDProbeMount() {
    difference() {
        translate([-barWidth*3/2+22,25,caseThickness/2]) cube([barWidth*3,15,20]);
         translate([-barWidth*3/2+22+7.5,25,10+caseThickness/2])  rotate([90,0,0]) cylinder(h=LEDProbeLength,d=8,center=true);
    }
}



module stick25mm() {
    color("red") cube([5,5,25],center=true);
}

*translate([5,40,20/2]) stick25mm();

module stick15mm() {
    color("red") cube([5,5,15],center=true);
}

*translate([22,40,15/2-2.5]) stick15mm();

module motorMount() {
    difference() {
        cube([motorBodyDiameter*2,motorBodyDiameter,motorLength-2.1],center=true);
        union() {
        translate([0,motorBodyDiameter/2-0,1]) cylinder(h=motorBodyLength+2, d=motorBodyDiameter+0.1,center=true);
           translate([0,0,3]) rotate([0,90,90]) cylinder(h=10, d=2,center=true);  //screw   hole    
        }
    }
}


module LEDProbe() {
    difference() {
        cylinder(h=LEDProbeLength,d=LEDProbeDiameter,center=true);
        cylinder(h=LEDProbeLength,d=LEDProbeDiameter-2,center=true);
    }
}

//translate([barWidth*2,50,15]) rotate([90,0,0]) LEDProbe();


module linearactuator() {
    case();
    LEDProbeMount();
    color("green") translate([0,0,15]) pulley();
    translate([0,0,18+pulleyThickness]) scotchYoke();
    translate([0,-pulleyDiameter/2-motorDiameter/2-spindleDiameter/2,(motorBodyLength+motorSpindleLength)/2])  motorMount();
    //#translate([0,-pulleyDiameter/2-motorDiameter/2-spindleDiameter/2+2,(motorBodyLength+motorSpindleLength)/2]) motorVibrator();

}

linearactuator();