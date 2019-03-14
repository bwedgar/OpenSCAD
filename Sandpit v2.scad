//sandpit
woodThickness=45;
woodWidth = 240;
scale=1/64;

module sandpit(length,width) {
    translate([0,width/2,0]) side (length);
        translate([0,-width/2,0]) side (length);
        translate([length/2,0,0])  rotate([0, 0,90]) side (width);
        translate([-length/2,0,0])  rotate([0, 0,90])  side (width);
}

module side(length) {
    //walls 
    cube ([length,woodThickness,woodWidth*2],center=true);
    //seat
    translate([0,0,woodWidth]) color("blue") cube ([length+woodWidth,woodWidth,woodThickness],center=true);
}

 

scale([scale,scale,scale]) sandpit (5500,3000);