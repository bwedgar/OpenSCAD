// opening flower

//variables

stemDiameter=20;
peduncleDiameter=stemDiameter/0.7;
peduncleHeight=20;
stalkHeight=20;
stalkDiameter=peduncleDiameter;
petalWidth=peduncleDiameter/2.2;
petalThickness=5;
petalHeight=45;

module axle() {
    rotate([0,90,0]) cylinder(h=petalWidth*3,d=2.5,center=true);
}

module hullCylinder() {
    for (i=[1:1:20]) {
        hull() {
        translate([-20,0,5*i/10]) cylinder(h=5,d1=i,d2=i+10);
        translate([-10,5,5*i/10]) cylinder(h=5,d1=i,d2=i+10);
    }
}
}
    
  *hullCylinder();

module petalBladeHalf() {
    hull() {
        translate([-20,0,0]) circle(d=2);
        translate([-10,5,0]) circle(d=4);
    }
    hull(){
        translate([-10,5,0]) circle(d=4);
        translate([0,7,0]) circle(d=6);
       
    }
}


module petalBlade() {
    linear_extrude(height = petalHeight/10, center = true) {
    petalBladeHalf();
    mirror([1,0,0]) petalBladeHalf();
    }
}
!petalBlade();

module petal(petalThickness1) {

  
            rotate([-25,0,0]) translate([ -petalWidth/2,peduncleDiameter/8,peduncleHeight/2.3 ]) 
    difference(){
        union() {
        cube([petalWidth-2,petalThickness1,petalHeight],center=false);
            translate([(petalWidth-2)/2,0,2]) cylinder(h=3,d=6, center=true);
        }
                union() {
        translate([petalWidth/2,petalThickness1/2,peduncleHeight*0.5])  axle();
            
            translate([petalWidth/2-1,petalThickness1/2,petalHeight-3]) cube([8,3,8],center=true);
                     translate([(petalWidth-2)/2,0,2]) cylinder(h=4,d=4, center=true);           
        }
    }
}

*petal(petalThickness);

module corolla(petalThickness1) {
     petal(petalThickness1);
    rotate([0,0,120])  petal(petalThickness1);
    rotate([0,0,240])  petal(petalThickness1);
    
  
}
module peduncleCutOut() {
      translate([0,peduncleDiameter/2,peduncleHeight*0.6]) cube([peduncleDiameter*0.45,petalWidth+2,peduncleHeight ],center=true);
            translate ([0, peduncleDiameter*0.45,peduncleHeight*0.8]) axle();
            translate([0,0,-(peduncleHeight+stalkHeight+0.2)/2]) cylinder(h=peduncleHeight*3,d=peduncleDiameter*0.7, center=false);
            
}


module peduncle() {
    difference() {
        union() {
        cylinder(h=peduncleHeight,d1=peduncleDiameter,d2=peduncleDiameter*1.3,center=false);
            translate([0,0,-stalkHeight]) cylinder(h=stalkHeight,d=stalkDiameter);
        }
        union() {
          peduncleCutOut();
              rotate([0,0,120]) peduncleCutOut();
    rotate([0,0,240]) peduncleCutOut();
        }
    }
}


peduncle();

module flower() {
    peduncle();
    color("blue") scale([.9,.9,.9]) corolla(petalThickness);
}

flower();