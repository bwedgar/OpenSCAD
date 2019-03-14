//Compass Mounting Bracket
$fn=20;
module side() {
    difference() {
        union() {
            rotate([30,0,0]) cube ([2.5,10.0,12.0], center=true) ;
    
            translate([0,-2.3,4]) rotate([0,90,0])  cylinder(h=2.5, d=10, center=true);
            translate([0,10,-7]) rotate ([70,0,0]) cube([2.5,10,19], center=true) ;
        }
        union() {
            translate([0,-2.2,4]) rotate([0,90,0]) cylinder(h=6,d=3,center=true);
            translate([0,8,-14]) rotate([0,0,0]) cube([3.5,28,15], center=true);
        }
    }
}

module base(){
  
       difference() {
        hull() {  
                                translate([-20.2,32.5,-7])   cylinder(h=3,d=3,center=true);   
                               translate([20.2,32.5,-7])   cylinder(h=3,d=3,center=true);  
                               translate([-20.2,-3.5,-7])   cylinder(h=3,d=3,center=true);  
                               translate([20.2,-3.5,-7])   cylinder(h=3,d=3,center=true); 
}
   // translate([0,15,-7]) cube([42,38,3],center=true);
        union(){
            
       %translate([0,-2,-7]) cube([21,6.3,3.5],center=true);
             translate([-11.5,23,-7])   cylinder(h=6,d=3,center=true);
                translate([11.5,23,-7])   cylinder(h=6,d=3,center=true);
      
        }    
}

        


}

 translate([-12,0,0]) side() ; 
translate([12,0,0]) side() ;
base();
