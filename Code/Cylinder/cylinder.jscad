// title: Music Box Cylinder
// author: Tiffany Lu

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

function pin() {
    return cube({size:[10,5,vspacing], center:true});
}

function makePins() {
    var pins = [];
    var lastangle = 0;
    for(var i=0; i<numnotes; i++) {
        var pinnum = notes[i][0];
        var time = notes[i][1];
        var angle = hspacing*time;
        var x = cos(angle)*radius;
        var y = sin(angle)*radius;
        lastangle = angle;
        var p = translate([x,y,0], translate([0,0,vspacing/2+pinnum*vspacing], rotate([0,0,angle], pin())));
        pins.push(p);
    }
    return pins;
}

function makeCylinder() {
    return cylinder({h:100, r:radius}).union(makePins());
}

function main() {
   return makeCylinder();
}
