//human figurine

armBend=90;
forearmLength=500;
forearmDiameter=100;


module arm() 
  {
    module forearm() {
        cylinder (d1=forearmDiameter*1.5,d2=forearmDiameter,h=forearmLength);
    }
        module backarm() {
        cylinder (d1=forearmDiameter*1.5,d2=forearmDiameter*2,h=forearmLength);
    }
    forearm();
    backarm();
   
     
    module armsJoin() { translate([0,0,forearmLength]) backarm();}
  armsJoin();
    module armBend() {
        rotate([0,60,0]) forearm();
    }
    armBend();
  }
  
 
  
  arm();
  