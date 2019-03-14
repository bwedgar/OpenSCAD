//linear actuator
trackwheelDiameter=50;
trackDiameter=30;
trackHeight=3;
trackWidth=3;
trackOffset=20; 
trackwheelHeight=10;
gearwheeelDiameter=50;
gearwheelHeight=5;
caseHeight=60;
caseDepth=80;
caseThickness=5;
caseWidth=80;
motorHeight=15;
motorDiameter=20;
motorLength=13;
motorSpindleLength=20;
barLength=70;
barWidth=5;
barHeight=5;

module bar() {
    color("blue") cube([barWidth,barLength,barHeight],center=true);
}

module barHousing() {
    difference() {
        cube([caseWidth,caseDepth,barHeight],center=true);
        bar();
    }
}

module case() {
    union() {
        translate([0,0,caseHeight/2-caseThickness]) barHousing();
        difference(){
        cube([caseWidth,caseDepth,caseHeight],center=true);
        translate([0,caseThickness+0.1,0]) cube([caseWidth+0.02,caseDepth-caseThickness,caseHeight-caseThickness*2],center=true);      
    }
}
}

module track() {
    difference() {
        cylinder(d=trackDiameter,h=trackHeight,center=true);
        cylinder(d=trackDiameter-trackWidth,h=trackHeight+0.01,center=true);
    }
}

//track();

module trackwheel() {
    difference() {
        cylinder(d=trackwheelDiameter,h=trackwheelHeight,center=true);
        translate([trackOffset/2,0,trackHeight*2]) track();
    }
}


module linearactuator() {
    bar();
    case();
    trackwheel();
}

linearactuator();