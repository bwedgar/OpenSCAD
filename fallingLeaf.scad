//falling leaf

module leaf(length,width,thickness) {
    union(){
   cube([length,length/2,thickness],center=true); 
        rotate([90,0,90]) cylinder(h=length+5,d=0.5,center=true);
}
}

module torus(od,thickness) {
    difference(){
    
        cylinder(h=thickness,d=od,center=true);
    
       {
           cylinder(h=thickness+1,d=od-2*thickness,center=true);
           translate([od/2,0,0]) cube([od,od,thickness+1],center=true);
       }
    }
}

module g1() {
    union(){
    rotate([$t*360,$t*360,$t*360]) leaf(10,5,1) ;
    rotate([0,$t*360,$t*360]) torus(12,1);
 
    }
}

module g2() {
union() {
    g1();
    rotate([0,0,$t*360])  torus(14,1);
}    
}

g2();