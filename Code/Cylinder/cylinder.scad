// cylinder params
radius = 25.4; //1 inch radius
height = 76.2; //3 inch height

// [comb-pin number, time]
// twinkle twinkle notes
notes = [[6,0],[3,0],[2,0],[6,12],[10,24],[6,24],[2,24],[10,36],[11,48],[6,48],[0,48],[11,60],[10,72],[6,72],[2,72],[9,97],[5,97],[0,97],[9,109],[8,121],[4,121],[2,121],[8,133],[7,145],[4,145],[1,145],[7,157],[6,169],[3,169],[2,169],[10,194],[6,194],[2,194],[10,206],[9,218],[5,218],[0,218],[9,230],[8,242],[4,242],[1,242],[8,254],[7,266],[4,266],[1,266],[10,291],[6,291],[2,291],[10,303],[9,315],[5,315],[0,315],[9,327],[8,339],[4,339],[1,339],[8,351],[7,363],[4,363],[1,363],[6,388],[3,388],[2,388],[6,400],[10,412],[6,412],[2,412],[10,424],[11,436],[6,436],[0,436],[11,448],[10,460],[6,460],[2,460],[9,485],[5,485],[0,485],[9,497],[8,509],[4,509],[2,509],[8,521],[7,533],[4,533],[1,533],[7,545],[6,557],[3,557],[2,557]];
// number of ticks
songlength = 557+24;
numnotes = 12.0;

// harry potter notes
//notes = [[11,0],[4,22],[15,22],[18,58],[4,69],[17,69],[4,91],[15,91],[22,138],[4,160],[20,160],[4,231],[17,231],[4,302],[15,302],[18,338],[4,349],[17,349],[10,371],[14,371],[0,418],[16,418],[4,440],[11,440],[7,487],[11,509],[0,556],[4,578],[15,578],[18,614],[4,625],[17,625],[4,647],[15,647],[22,694],[3,716],[13,716],[18,716],[25,716],[7,817],[10,919],[3,966],[7,966],[13,966],[18,966],[24,966],[1,988],[12,988],[16,988],[23,988],[5,1089],[8,1191],[1,1238],[5,1238],[12,1238],[16,1238],[19,1238],[1,1260],[12,1260],[15,1260],[23,1260],[4,1361],[9,1463],[22,1499],[1,1510],[4,1510],[9,1510],[12,1510],[15,1510],[21,1510],[2,1532],[10,1532],[4,1633],[6,1735],[2,1782],[4,1782],[18,1782],[4,1804],[15,1804]];
// number of ticks
//songlength = 1804+47;
// number of comb teeth
//numnotes = 26.0;

// one measure spacing
hspacing = 2*PI*radius/songlength;
// comb-pin spacing
vspacing = height/numnotes;

module makeCylinder() {
    union() {
        cylinder(h = height, r = radius, $fn=256);
        for (i = [0:len(notes)-1]) {
            pinnum = notes[i][0];
            time = notes[i][1];
            angle = hspacing*time/radius*180/PI;
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
        $fn=64;
        translate([0,0,height]) cylinder(h=4.7625,r=4.7625);
    }
}

completeCylinder();
//translate([radius+5,0,0]) cylinder(h=height,r=1);

