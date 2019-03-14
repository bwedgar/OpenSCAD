//SD card holder
difference() {
    cube([40,30,30], center=true);
    translate([0,0,10]) cube([25,2.5,12],center=true);
}
translate([9,14,0]) rotate([-90,180,0]) linear_extrude(2) text("SD",10);
