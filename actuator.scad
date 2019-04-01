//linear actuator

//use <motor mount.scad>;
trackwheelDiameter=45;
trackwheelHeight=10;
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
yokeLength=40;
yokeWidth=15;
yokeSlotLength=30;
yokeSlotWidth=5;
pinOffset=yokeSlotLength/2-1;
pinHeight=8;
motorLength=14;
motorDiameter=6;
spindleDiameter=1.5;
spindleLength=6;
LEDProbeLength=30;
LEDProbeDiameter=6;





module base() {
    difference() {
        cube([caseWidth,caseDepth,baseThickness],center=true);
        translate([0,-20,baseThickness/2]) union() {
            cylinder(h=baseThickness/2+1, d=4);
            cylinder(h=baseThickness+1, d=2);  
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
        cylinder(h=20,d=10,center=true);
        cylinder(h=20,d=8,center=true);
}
}

translate([0,0,10]) sleeve();

module axle() {
    color("black") cylinder(h=20,d=8,center=true);
    color("black")  translate([0,0,-10]) cylinder(h=10,d=18,center=true);
}

translate([0,0,0]) axle();



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
    color("blue") translate([0,barLength/2,0]) cube([barWidth,barLength,barHeight],center=true);
    difference() {
    color("blue") rotate([0,0,90]) cube([yokeWidth,yokeLength,barHeight],center=true);
    rotate([0,0,90]) cube([yokeSlotWidth,yokeSlotLength,barHeight],center=true);
    }
}

translate([0,0,18+trackwheelHeight]) scotchYoke();

module sliderMount() {
    translate([-barWidth*3/2,25,caseThickness/2]) cube([barWidth*3,15,35]);
}

sliderMount();

module motorMount() {
    difference() {
        cube([motorDiameter*2,motorDiameter,motorLength],center=true);
        translate([0,motorDiameter/2-0,0]) cylinder(h=motorLength+0.1, d=motorDiameter+0.1,center=true);
    }
}

module motor() {
    color("silver") union() {
    cylinder(h=14,d=6);
    cylinder(h=25,d=1.5);
    }
}

module LEDProbe() {
    difference() {
        cylinder(h=LEDProbeLength,d=LEDProbeDiameter,center=true);
        cylinder(h=LEDProbeLength,d=LEDProbeDiameter-2,center=true);
    }
}

translate([barWidth*2,50,15]) rotate([90,0,0]) LEDProbe();


module linearactuator() {
  //  bar();
    case();
    color("green") translate([0,0,20]) trackwheel();
 translate([0,-trackwheelDiameter/2-motorDiameter/2-spindleDiameter/2,6])  motorMount();
    translate([0,-trackwheelDiameter/2-motorDiameter/2-spindleDiameter/2+2,2]) motor();

}

linearactuator();
