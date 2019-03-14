//turntable 
diameter=150;
height=5;
bufferWidth=5;
bufferHeight=5;
trackSpacing=22;
entryTrackLength=30;

module perimeter() {
    difference() {
       
        color("blue")  cylinder(d=500,h=height+0.2,center=true);
           color("green") cylinder(d=diameter-entryTrackLength,h=height+0.1,center=true);
    }
  

}




module straightTrack(length) {
      translate([-diameter/2,trackSpacing/2,0]) cube([length,bufferWidth,bufferHeight],center=false);
            translate([-diameter/2,-trackSpacing/2-bufferWidth,0]) cube([length,bufferWidth,bufferHeight],center=false);
}

module entryTrack() {
    color("red") translate([diameter-entryTrackLength/2,0,height]) straightTrack(entryTrackLength/2);
    
}

module curvedTrack(diameter) {
    union() {
        difference() {
        cylinder(d=diameter, h=height,center=true) ;
        cylinder(d=diameter-bufferWidth*2, h=height+0.1, center=true) ;
    }
          difference() {
        cylinder(d=diameter-trackSpacing*2-bufferWidth, h=height,center=true) ;
        cylinder(d=diameter-trackSpacing*2-bufferWidth*3, h=height+0.1, center=true) ;
    }
}
}



module base() {
    
       difference() {
           union() {
           cylinder(d=diameter,h=height);
      color("black") translate([0,0,height]) straightTrack(diameter);
    color("black") translate([0,-diameter/2-trackSpacing/2,height*3/2-0.1]) curvedTrack(diameter);
          color("green") translate([-14,+diameter/2+trackSpacing/2+38,height*3/2-0.1]) curvedTrack(diameter*1.5);       
       }
       
       {
      translate([0,0,height*3/2]) perimeter();
       }
   }
}

base();
entryTrack(); 
rotate([0,0,45]) entryTrack();
rotate([0,0,-45]) entryTrack();
rotate([0,0,-135]) entryTrack();
rotate([0,0,-180]) entryTrack();
rotate([0,0,-212]) entryTrack();
*perimeter();