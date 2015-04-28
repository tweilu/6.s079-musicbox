// [comb-pin number, time]
// Generate comb-pin number in Javascript probably
//notes = [[0,0], [1,1.0], [2,2.0], [3,2.0], [4,3.0], [5,4.0], [6,5.0], [7,7.0]];
// twinkle twinkle notes
notes = [[0,0],[0,0.25],[4,0.5],[4,0.75],[5,1.0],[5,1.25],[4,1.5],[3,2.0],[3,2.25],[2,2.5],[2,2.75],[1,3.0],[1,3.25],[0,3.5],[4,4.0],[4,4.25],[3,4.5],[3,4.75],[2,5.0],[2,5.25],[1,5.5],[4,6.0],[4,6.25],[3,6.5],[3,6.75],[2,7.0],[2,7.25],[1,7.5],[0,8.0],[0,8.25],[4,8.5],[4,8.75],[5,9.0],[5,9.25],[4,9.5],[3,10.0],[3,10.25],[2,10.5],[2,10.75],[1,11.0],[1,11.25],[0,11.5]];
// number of comb pins
numnotes = 6.0;
// number of measures
songlength = 12.0;
// one measure spacing
hspacing = 360/songlength;

// cylinder params
radius = 25.4; //1 inch radius
height = 76.2; //3 inch height
// comb-pin spacing
vspacing = height/numnotes;

module makeCylinder() {
    union() {
        cylinder(h = height, r = radius, $fn=128);
        for (i = [0:len(notes)-1]) {
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
    rotate([90,90,0]) trapezoid(vspacing, vspacing*0.5,6.35,1);
}

module trapezoid(width_base, width_top,height,thickness) {
  translate([0,0,-thickness/2]) linear_extrude(height = thickness) polygon(points=[[-width_base/2,-height/2],[width_base/2,-height/2],[width_base/2-(width_base-width_top)/2,height/2],[-width_base/2+(width_base-width_top)/2,height/2]], paths=[[0,1,2,3]]);
}

module completeCylinder() {
    union() {
        difference() {
            makeCylinder();
            cube(size=[6.73519,6.73519,12.7], center=true);
        }
        translate([0,0,height]) cylinder(h=4.7625,r=4.7625);
    }
}

completeCylinder();