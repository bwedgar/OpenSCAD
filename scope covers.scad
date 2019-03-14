//Line Marking paint can retaining clip

length=30;
thickness=2;
insideDiameter=26.6;


module cover(length,insideDiameter,thickness) {
    difference() {
        union(){
   cylinder(h=thickness, d=insideDiameter+2*thickness,center=true);
        cylinder(h=length, d=insideDiameter+2*thickness,center=true);
                translate([(insideDiameter+3*thickness)/2,0,-length/2]) cylinder(h=4, d=6 );
              
        }
   union() {
               translate([0,0,thickness+0.1]) cylinder(h=length, d=insideDiameter,center=true);
                   translate([(insideDiameter+3*thickness)/2,0,-length/2-0.1]) cylinder(h=5.1, d=3 );
   }
}
}

cover(length,insideDiameter,thickness);