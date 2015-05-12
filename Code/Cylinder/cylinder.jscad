notes = [[6,0],[3,0],[2,0],[6,12],[10,24],[6,24],[2,24],[10,36],[11,48],[6,48],[0,48],[11,60],[10,72],[6,72],[2,72],[9,97],[5,97],[0,97],[9,109],[8,121],[4,121],[2,121],[8,133],[7,145],[4,145],[1,145],[7,157],[6,169],[3,169],[2,169],[10,194],[6,194],[2,194],[10,206],[9,218],[5,218],[0,218],[9,230],[8,242],[4,242],[1,242],[8,254],[7,266],[4,266],[1,266],[10,291],[6,291],[2,291],[10,303],[9,315],[5,315],[0,315],[9,327],[8,339],[4,339],[1,339],[8,351],[7,363],[4,363],[1,363],[6,388],[3,388],[2,388],[6,400],[10,412],[6,412],[2,412],[10,424],[11,436],[6,436],[0,436],[11,448],[10,460],[6,460],[2,460],[9,485],[5,485],[0,485],[9,497],[8,509],[4,509],[2,509],[8,521],[7,533],[4,533],[1,533],[7,545],[6,557],[3,557],[2,557]];
// number of ticks
songlength = 557+24;
numnotes = 12.0;

radius = 25.4; //1 inch radius
height = 76.2; //3 inch height

// one measure spacing
hspacing = 2*Math.PI*radius/songlength;
// comb-pin spacing
vspacing = height/numnotes;

function trapezoid(width_base, width_top, height, thickness) {
	var poly = CAG.fromPoints([[-width_base/2,-height/2],[width_base/2,-height/2],[width_base/2-(width_base-width_top)/2,height/2],[-width_base/2+(width_base-width_top)/2,height/2]]);
	poly = poly.extrude({offset:[0,0,thickness]});
	return poly.translate([0,0,-thickness/2]);
}

function pin() {
	var trap = trapezoid(vspacing, vspacing*0.5, 6.35, 1);
	trap = trap.rotateX(90);
	trap = trap.rotateY(90);
	return trap;
}

function makeCylinder() {
	var cylinder = CSG.cylinder({ start:[0,0,0], end:[0,0,height], radius:radius });
    for(var i=0; i<notes.length; i++) {
        var pinnum = notes[i][0];
        var time = notes[i][1];
        var angle = hspacing*time/radius;
        var x = Math.cos(angle)*radius;
        var y = Math.sin(angle)*radius;

        var p = pin();
        p = p.rotateZ(angle*180/Math.PI);
        p = p.translate([x,y,vspacing/2+pinnum*vspacing]);

        cylinder = cylinder.union(p);
    }
    return cylinder;
}

function completeCylinder() {
	var indent = CSG.cube({ center:[0,0,0], radius:[6.73519/2,6.73519/2,12.7/2] });
	var post = CSG.cylinder({ start:[0,0,height], end:[0,0,height+4.7625], radius:4.7625 });
	var cylinder = makeCylinder();
	cylinder = cylinder.subtract(indent);
	cylinder = cylinder.union(post);
	return cylinder;
}

function main() {
	return completeCylinder();
}

