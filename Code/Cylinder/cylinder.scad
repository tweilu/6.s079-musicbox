// [pin number, length]
// Generate pin number in Javascript probably
// TODO: figure out how to indicate simultaneous notes...
notes = [[1,0.25], [2,0.25], [3,0.25], [4,0.25], [5,0.25], [6,0.25], [7,0.25], [8,0.25]];
numnotes = 8;
radius = 25;
// whole note spacing
hspacing = 60;
vspacing = 10;

module makeCylinder() {
    union() {
        cylinder(h = 100, r = radius, $fn=128);
        for (i = [0:numnotes-1]) {
            pinnum = notes[i][0];
            length = notes[i][1];
            angle = hspacing*length*i;
            x = cos(angle)*radius;
            y = sin(angle)*radius;
            translate([x,y,0]) {
                translate([0,0,vspacing/2+pinnum*vspacing]) rotate([0,0,angle]) pin();
            }
        }
    }
}

// TODO: optimize pin shape
module pin() {
    cube(size = [10,5,vspacing], center = true);
}

makeCylinder();