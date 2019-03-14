// Garden Design
//pavers 450x450 www.firthpavers.co.nz 


$fn=30;
$vpd=14;

//$vpr=[90,0,180];

$vpt=[ 2.86, 5.59, 1.33 ];
 $vpr = [ 71.80, 0.00, 89.00 ];


paverThickness=0.05;


planterBoxWidth=1.2;
planterBoxLength=1.2;
planterBoxHeight=0.4;
planterBoxDiameter=2.6;

module sculpture(east,north,scale) {
      translate([east+scale*0.7/2,north+scale*0.7/2,0]) {
          scale([scale,scale,scale]) {
                translate([0,0,0.6]) cylinder(h=1,d1=0.7, d2=0.4,center=true);
                translate([0,0,1]) sphere(d=0.3, center=true);
         }
     }
 }
 
 module paving(east,north,distanceEast,distanceNorth){
      color("grey") {
        translate([east,north,0]) {
            for (i=[0:distanceEast-1]) {
                for (j=[0:distanceNorth-1]) { 
                    translate([gridSize*i,gridSize*j,0]) cube([gridSize-0.02,gridSize-0.02,paverThickness]);
                }
            }
        }
    }
}


 
 module mondograss(east,north,distanceEast,distanceNorth){
      color("green") {
        translate([east,north,0]) {
            for (i=[0:distanceEast-1]) {
                for (j=[0:distanceNorth-1]) { 
                    translate([gridSize*i,gridSize*j,0]) cube([gridSize-0.02,gridSize-0.02,paverThickness*3]);
                }
            }
        }
    }
}

 module rushes(east,north,distanceEast,distanceNorth){
      color("green") {
        translate([east,north,0]) {
            for (i=[0:distanceEast-1]) {
                for (j=[0:distanceNorth-1]) { 
                    #translate([gridSize*i,gridSize*j,0]) cube([gridSize-0.02,gridSize-0.02,paverThickness*17]);
                }
            }
        }
    }
}

 module fishpond(east,north) {
        // 
              translate([east,north,0]) 
     
     {
         difference() {
         color("white")  translate([0,0,planterBoxHeight/2]) cube([planterBoxWidth,planterBoxLength,planterBoxHeight],center=true);
              
                      translate([0,0,planterBoxHeight])  color("green") cube([planterBoxWidth-0.3,planterBoxLength-0.3,planterBoxHeight+0.1],center=true);
             }
                  translate([0,0,paverThickness]) color("blue") cube([planterBoxWidth-0.3,planterBoxLength-0.3,0.5],center=true);
                               
     }  
      
}


module tree(east,north,width,color) {
    color(color) {
        translate([east,north,0]) {
        translate([0,0,width]) sphere(d=width);
            cylinder(d=width/8,h=width);
        
    }
}
}

module hedge(east,north,distanceEast,distanceNorth,height,color) {
    color(color) {
        translate([east,north,0]) {
            cube([distanceEast,distanceNorth,height]);
        }
    }
}

module fence(east,north,direction, width,length,height,color) {
    color(color) translate([east,north,0])    rotate([0,0,direction]) { cube([width,length,height]);}
}


module planterBox(east,north) {
          
              translate([east,north,0]) { 
              color("white")  translate([0,0,planterBoxHeight/2]) cube([planterBoxWidth,planterBoxLength,planterBoxHeight],center=true);
                  translate([0,0,planterBoxHeight]) color("cyan") cube([planterBoxWidth-0.3,planterBoxLength-0.3,planterBoxHeight],center=true);
                               translate([0,0,planterBoxHeight*1.5]) color("mediumpurple") cube([planterBoxWidth-0.3,planterBoxLength-0.3,planterBoxHeight/2],center=true);
          
      }
}

module planterBoxRound(east,north,quadrant) {
          
              translate([east,north,0]) { 
                    rotate([0,0,90*quadrant]) {
              difference() {
                  union() {
                  color("white")  translate([0,0,planterBoxHeight/2]) cylinder(d=planterBoxDiameter,h=planterBoxHeight,center=true);
                         color("cyan")  translate([0,0,planterBoxHeight+0.2]) cylinder(d=planterBoxDiameter-0.4,h=planterBoxHeight+0.25,center=true);
                                    color("mediumpurple")  translate([0,0,planterBoxHeight+0.4]) cylinder(d=planterBoxDiameter-0.5,h=planterBoxHeight+0.45,center=true);
              }
          
         translate([-planterBoxDiameter,-planterBoxDiameter/2,-0.4]) cube([planterBoxDiameter,planterBoxDiameter,planterBoxHeight+2]);
          }
          color("white") translate([-0.2,-planterBoxDiameter/2.0]) cube([0.2,planterBoxDiameter,planterBoxHeight]);
      }
  }
}


module seat(east,north) {
          
              translate([east,north,0]) { 
                  difference() {
              color("brown")  translate([0,0,planterBoxHeight]) cube([planterBoxWidth/2,planterBoxLength,planterBoxHeight],center=true);
                  translate([-0.2,0,planterBoxHeight*1.5])   cube([planterBoxWidth-0.3,planterBoxLength-0.3,planterBoxHeight],center=true);
                  }
                           
      }
}

module person(east,north,height,quadrant) {
    translate([east,north,1.1]) { 
        rotate([0,0,90*quadrant]) 
        scale([height/1.72,height/1.72,height/1.72]) {
        //torso
        color("pink") scale([1,0.8,1]) cylinder(h=0.7,d1=0.36,d2=0.45,center=true);
        //head
        color("moccasin") translate([0,0,0.7/2+0.225/2+0.05]) scale([1.5,1.5,2.5]) sphere(d=0.15,center=true);
            //hat
            color("fuchsia") difference() {
                 translate([0,0,0.7/2+0.225/2+0.05]) scale([1.5,1.5,2.5]) sphere(d=0.17,center=true);
                translate([0,0,0.7/2+0.225/2]) scale([1.5,1.5,2.5]) cylinder(d=0.2,h=0.1,center=true);
            }
        //legs
        color("fuchsia") translate([0.07,0,-0.7]) cylinder(h=0.8,d1=0.1,d2=0.15,center=true);
               color("fuchsia")  translate([-0.07,0,-0.7]) cylinder(h=0.8,d1=0.1,d2=0.15,center=true);
        //arms
                color("pink") translate([0.18,0.0,-0.1]) cylinder(h=0.9,d1=0.08,d2=0.12,center=true);
                    color("pink") translate([-0.18,0.0,-0.1]) cylinder(h=0.9,d1=0.08,d2=0.12,center=true);
            //hands
                         color("moccasin") translate([0.18,0.0,-0.45]) cylinder(h=0.2,d1=0.08,d2=0.09,center=true);
                     color("moccasin") translate([-0.18,0.0,-0.45]) cylinder(h=0.2,d1=0.08,d2=0.09,center=true);
    }
}
    
}


module personseated (east,north,height,quadrant) {
    translate([east,north,0.8]) { 
        rotate([0,0,90*quadrant]) 
        scale([height/1.72,height/1.72,height/1.72]) {
        //torso
        color("pink") scale([1,0.8,1]) cylinder(h=0.7,d1=0.36,d2=0.45,center=true);
        //head
        color("moccasin") translate([0,0,0.7/2+0.225/2+0.05]) scale([1.5,1.5,2.5]) sphere(d=0.15,center=true);
                     //hat
            color("fuchsia") difference() {
                 translate([0,0,0.7/2+0.225/2+0.05]) scale([1.5,1.5,2.5]) sphere(d=0.17,center=true);
                translate([0,0,0.7/2+0.225/2]) scale([1.5,1.5,2.5]) cylinder(d=0.2,h=0.1,center=true);
            }
        //thighs
        color("fuchsia") translate([0.07,0.2,-0.4]) rotate([90,0,0]) cylinder(h=0.4,d1=0.1,d2=0.15,center=true);
                color("fuchsia") translate([-0.07,0.2,-0.4]) rotate([90,0,0]) cylinder(h=0.4,d1=0.1,d2=0.15,center=true);
            //calfs
             color("fuchsia")  translate([0.07,0.35,-0.6]) cylinder(h=0.4,d1=0.1,d2=0.15,center=true);
                       color("fuchsia")  translate([-0.07,0.35,-0.6]) cylinder(h=0.4,d1=0.1,d2=0.15,center=true);
        //arms
                color("pink") translate([0.18,0.0,-0.1]) cylinder(h=0.9,d1=0.08,d2=0.12,center=true);
                    color("pink") translate([-0.18,0.0,-0.1]) cylinder(h=0.9,d1=0.08,d2=0.12,center=true);
            //hands
                         color("moccasin") translate([0.18,0.0,-0.45]) cylinder(h=0.2,d1=0.08,d2=0.09,center=true);
                     color("moccasin") translate([-0.18,0.0,-0.45]) cylinder(h=0.2,d1=0.08,d2=0.09,center=true);
    }
}
    
}


module personbending (east,north,height,quadrant) {
    translate([east-0.1,north,0.8]) { 
        rotate([0,0,90*quadrant]) 
        scale([height/1.72,height/1.72,height/1.72]) {
            rotate([-30,0,0]){
        //torso
        color("pink") scale([1,0.8,1]) cylinder(h=0.7,d1=0.36,d2=0.45,center=true);
        translate([0,-0.15,0]) rotate([-20,0,0]) {
            //head
        color("moccasin") translate([0,0,0.7/2+0.225/2+0.05]) scale([1.5,1.5,2.5]) sphere(d=0.15,center=true);
                     //hat
            color("fuchsia") difference() {
                 translate([0,0,0.7/2+0.225/2+0.05]) scale([1.5,1.5,2.5]) sphere(d=0.17,center=true);
                translate([0,0,0.7/2+0.225/2]) scale([1.5,1.5,2.5]) cylinder(d=0.2,h=0.1,center=true);
            }
        }
                 //arms
                translate([0,0.1,0]) rotate([30,0,0]) {
                    color("pink") translate([0.18,0.0,-0.1]) cylinder(h=0.9,d1=0.08,d2=0.12,center=true);
                    color("pink") translate([-0.18,0.0,-0.1]) cylinder(h=0.9,d1=0.08,d2=0.12,center=true);
            //hands
                         color("moccasin") translate([0.18,0.0,-0.45]) cylinder(h=0.2,d1=0.08,d2=0.09,center=true);
                     color("moccasin") translate([-0.18,0.0,-0.45]) cylinder(h=0.2,d1=0.08,d2=0.09,center=true);
                }
        }
             //legs
        color("fuchsia") translate([0.07,-0.15,-0.7]) cylinder(h=0.8,d1=0.1,d2=0.15,center=true);
               color("fuchsia")  translate([-0.07,-0.15,-0.7]) cylinder(h=0.8,d1=0.1,d2=0.15,center=true);
   
    }
}
    
}

module garden() {
   
    //people
      translate([0,0,1.0]) person(7.2,6,1.5,1); //on terrace
    person(4.5,9.2,1.5,4);
        person(2.4,1.8,1.5,2);
         personbending(3.3,9.6,1.5,1);
     personseated(5,6,1.5,1);

    
    
    //PERIMETER
   
    #fence(0,0,0,0.1,11,1.8,"tan");
    #fence(0,0,-90,0.1,12,1.8,"tan");
     #fence(0,11,-90,0.1,8.6,1.8,"tan");
    
     #fence(12,0,0,0.1,2.0,1.8,"tan");
     #fence(12,2,90,0.1,5.5,1.8,"tan");
    
    fence(6.6,2,0,0.1,7.0,1.2,"tan");  
   
   
   //PAVING
    
    //terrace edge
    translate([0,0,1.2]) paving(6,0.2,6,20);
    
   //PLANTS 
   //sysygium hedge
   hedge(0,0,0.7,8,3.5,"lightgreen");  
   //kowhai
   tree(1,10,3,"yellow"); 
   //mandarin
   tree(3.5,2.0,2,"green");
   //puka
   tree(4,12,4,"green");
  
     
//paths from steps
       //   paving(5,31,23,3);          
   

    //mondograss(13,11,1,6);
  
       
//rushes(13,27,1,7);       
        
  
  fishpond(8,31);
  
      //PLANTERS
      planterBoxRound(6,4,2);
          planterBoxRound(6,8,2);
              planterBoxRound(1.5,4,0);
                  planterBoxRound(1.5,8,0);
     // planterBox(2.4,4.2);
 
      
                              
 sculpture(3.3,6,1.2);
 seat(5,6);
    
                                
    
}
garden();
