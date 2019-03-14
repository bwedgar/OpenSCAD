//vacuum line tool for swimming pool
module indents() {
    translate([0,4+9/2,0]) cube([19,9,8],center=true) ;
    translate([0,-4-9/2,0]) cube([19,9,8],center=true) ;
    translate([0,0,5]) cylinder(h=5,d=50,center=true);
     translate([0,0,8]) minkowski() {
         minkowski() {
            minkowski() {
              translate([0,0,15]) cube([20,12,25],center=true) ; //handle
                union() {
                 cylinder(h=25,r=4);
                }
             rotate([0,90,0]) cylinder(h=2,r=4);    
             
         }
        rotate([90,0,0]) cylinder(h=2,r=4);   
     }
 }
}

indents();