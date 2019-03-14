// smartphone adapter for "Push To Telescope"
$fn=30;
thickness=1.5; 
iphoneWidth=74.5;
iphoneThickness=13;
retainerWidth=6;
baseHeight=90;


   
module drillHoles() {
                translate([-12,3,0]) rotate([90,0,0]) cylinder(h=12,d=3,center=true);
         translate([-12,-0.6,0]) rotate([90,0,0]) cylinder(h=2,d2=5.4,d1=3,center=true); //countersink
    
                   translate([12,3,0]) rotate([90,0,0]) cylinder(h=12,d=3,center=true);
           translate([12,-0.6,0]) rotate([90,0,0]) cylinder(h=2,d2=5.4,d1=3,center=true);//countersink
}

module holders() {
    difference() {
        union() {
        color("blue") translate([0,20,0])   cube([70,30,10],center=true);
        }
        union() {
       translate([0,16,0])  cube([35,3,100],center=true); //belt slot
            translate([0,65,30]) rotate([0,90,0]) cylinder(h=120,d=100,center=true);
            translate([0,7,0]) drillHoles();
        }
    }
}
    *holders();

module base(){
    difference() {
        union() {
    translate([0,0,-5]) cube([iphoneWidth+thickness*2,3,90],center=true);
    //sides
    color("red") translate([iphoneWidth/2+thickness/2,-3-5,-5])   cube([thickness,iphoneThickness,90],center=true);
        color("red") translate([-iphoneWidth/2-thickness/2,-3-5,-5])   cube([thickness,iphoneThickness,90],center=true);
       color("red") translate([0,-8,-49])  cube([iphoneWidth,iphoneThickness,thickness],center=true);
    //tops
    translate([+iphoneWidth/2+thickness-retainerWidth,-3-5-1.0-12/2,-50]) cube([retainerWidth,1.5,90]);
    translate([-iphoneWidth/2-thickness,-3-5-1.0-12/2,-50]) cube([retainerWidth,1.5,90]);
    *translate([0,1,-5]) rotate([0,135,0]) holders();
        }
        union() {
 translate([-baseHeight/2+25,0,iphoneWidth/2-20]) rotate([0,-45,0]) drillHoles();
            translate([baseHeight/2-25,0,-iphoneWidth/2+10]) rotate([0,-45,0]) drillHoles();
        }
    }
}


module iPhone() {
    cube([75,12,140],center=true);
    }
    
//rotate([0,45,0])  
    base();
    *color("black")  rotate([0,45,0]) translate([0,-8,28])iPhone();
