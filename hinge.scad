//hinge
$fn=30;
length=12;
diameter=6;
axleDiameter=2;
stemLength=10;
numberPairs=5;
baseWidth=25;

module hinge() {
    translate([3,0,0]) rotate([0,-135,0]) {
        difference() {
        union() {
            rotate([90,0,0]) cylinder(h=length,d=diameter,center=true);
            translate([0,0,stemLength/2]) cube([diameter,length,stemLength],center=true);
        }
        union() {
              translate([1,0,stemLength*1.00]) rotate([0,45,0]) cube([diameter*2,diameter*3,diameter], center=true);
              rotate([90,0,0]) cylinder(h=length+2,d=axleDiameter,center=true);
        }
    }
}
}

*hinge();



color("red") {
cube([60,length*2,30]);
translate([60,length/2,30]) hinge();
}

module base() {
color("blue") {
cube([60,length*2,30]);
translate([60,length/2,30]) hinge();
}
}

module lid() {
translate([0,length*2,60]) rotate([180,0,0]) base();
}

*lid();

translate([120+6,0,60]) rotate([0,180,0]) lid();