// [comb-pin number, time]
// Generate comb-pin number in Javascript probably
notes = [[0,0], [1,1.0], [2,2.0], [3,2.0], [4,3.0], [5,4.0], [6,5.0], [7,7.0]];
numnotes = 8;
// number of measures
songlength = 8.0;
// one measure spacing
hspacing = 360/songlength;

radius = 25;
height = 100;
// comb-pin spacing
vspacing = height/numnotes;

module makeCylinder() {
    union() {
        cylinder(h = height, r = radius, $fn=128);
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

module pin() {
    //cube(size = [10,5,vspacing], center = true);
    rotate([90,90,0]) trapezoid(vspacing, vspacing*3/5,8,3);
}

module trapezoid(width_base, width_top,height,thickness) {
  translate([0,0,-thickness/2]) linear_extrude(height = thickness) polygon(points=[[-width_base/2,-height/2],[width_base/2,-height/2],[width_base/2-(width_base-width_top)/2,height/2],[-width_base/2+(width_base-width_top)/2,height/2]], paths=[[0,1,2,3]]);
}

makeCylinder();