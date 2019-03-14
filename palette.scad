//palette 
length=160;
width=50;

depthMax=20;
depthMin=5;

wallThickness=1.5;

panY=width/3;
panX=(length-wallThickness*2)/13;

module base() {
    difference() {
        cube([length,width,depthMax]);
        union() {
            translate([panX/2*0+wallThickness,wallThickness,wallThickness]) cube([panX,panY,depthMax]);
        }
    }
}

base();