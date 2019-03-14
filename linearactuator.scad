//linear actuator

use <motor mount.scad>;
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
baseThickness=5;
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

module base() {
        cube([caseWidth,caseDepth,baseThickness],center=true);
    }


module back() {
        cube([caseWidth,baseThickness,caseDepth],center=true);
    }


module case() {
    union() {
       base();
   translate([0,-caseDepth/2,caseHeight/2]) back();    
    }
}




module trackwheel() {
    difference() {
        cylinder(d=trackwheelDiameter,h=trackwheelHeight,center=true);
        translate([trackOffset/2,0,trackHeight*2]) track();
    }
}


module linearactuator() {
    bar();
    case();
    translate([0,0,20]) trackwheel();
   translate([0,20,0]) motorMount();


 
}

linearactuator();