//Line Marking paint can retaining clip

length=82;
width=82;
diameter=62;
thickness=2;

module clip(length,width,diameter,thickness) {
    difference() {
        union(){
   cube([length,width,thickness],center=true); 
            linear_extrude(thickness ) translate([-35,-14,0]) rotate([0,0,90])  text("CAN CLIP",5);
            cylinder(h=12,d=70);
        }
   union() {
       cylinder(h=thickness+0.1,d=diameter,center=true);
       translate([30,0,0]) cube([diameter,diameter,thickness+0.1],center=true);
       cylinder(h=12.1,d=66);
       translate([44,0,6]) cube([70,70,12.1],center=true);
   }
}
}

clip(length,width,diameter,thickness);