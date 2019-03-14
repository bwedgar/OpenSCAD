//Line Marking paint can retaining clip

length=82;
width=82;
diameter=62;
thickness=1;

module clip(length,width,diameter,thickness) {
    difference() {
        union(){
   cube([length,width,thickness],center=true); 
            linear_extrude(thickness*2) translate([-32,-20,0]) rotate([0,0,90])  text("CAN CLIP",7);
        }
   union() {
       cylinder(h=thickness+0.1,d=diameter,center=true);
       translate([30,0,0]) cube([diameter,diameter,thickness+0.1],center=true);
   }
}
}

clip(length,width,diameter,thickness);