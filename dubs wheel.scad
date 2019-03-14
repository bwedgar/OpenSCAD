// dubsWheel.scad - Basic example of CSG usage



union() {
    cylinder(2,15,15, center=0);
    cylinder(4,12,12, center=0);
}



echo(version=version());
// Written by Brian Edgar