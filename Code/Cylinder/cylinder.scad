// [comb-pin number, length]
// Generate comb-pin number in Javascript probably
notes = [[1,0], [2,1.0], [3,1.5], [4,2.0], [5,3.0], [6,4.0], [7,5.0], [8,7.0]];
numnotes = 8;
// number of measures
songlength = 8.0;
radius = 25;
// one measure spacing
hspacing = 360/songlength;
// comb-pin spacing
vspacing = 10;

module makeCylinder() {
    union() {
        cylinder(h = 100, r = radius, $fn=128);
        for (i = [0:numnotes-1]) {
            pinnum = notes[i][0];
            time = notes[i][1];
            angle = hspacing*time;
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