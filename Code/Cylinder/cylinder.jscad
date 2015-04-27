// title: OpenJSCAD.org Logo
// author: Rene K. Mueller 
// license: Creative Commons CC BY
// URL: http://openjscad.org/#examples/logo.jscad
// revision: 0.003
// tags: Logo,Intersection,Sphere,Cube

// [pin number, length]
// Generate pin number in Javascript probably
// TODO: figure out how to indicate simultaneous notes...
notes = [[1,0.25], [2,0.5], [3,0.25], [4,0.25], [5,0.25], [6,0.25], [7,0.25], [8,0.25]];
numnotes = 8;
radius = 25;
// whole note spacing
hspacing = 60;
vspacing = 10;

function pin() {
    return cube({size:[10,5,vspacing], center:true});
}

function makePins() {
    var pins = [];
    var lastangle = 0;
    for(var i=0; i<numnotes; i++) {
        var pinnum = notes[i][0];
        var length = notes[i][1];
        var angle = lastangle + hspacing*length;
        var x = cos(angle)*radius;
        var y = sin(angle)*radius;
        lastangle = angle;
        var p = translate([x,y,0], translate([0,0,vspacing/2+pinnum*vspacing], rotate([0,0,angle], pin())));
        pins.push(p);
    }
    return pins;
}

function makeCylinder() {
    return cylinder({h:100, r:radius, $fn:128}).union(makePins());
}

function main() {
   return makeCylinder();
}
