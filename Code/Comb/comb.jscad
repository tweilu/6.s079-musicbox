//basic parameters
kerf=0.00;
width = 3.0;
height = 1.25;
tine_width = 3/64+2*kerf;
thick = 0.036;

//material parameters
steel = [0.289,28500000];
pla = [0.045159115, 508000];
mat = steel;//choose the material
density = mat[0]; //lbs/in3
Y = mat[1]; //young's modulus in psi

//useful calculated constants


function tine_length(frequency) { return Math.sqrt(0.162 * thick / frequency * Math.sqrt(Y/density));}

function pitch_to_freq(pitch) { return 440*(Math.pow(2.0,((pitch-69.0)/12))); }

function make_comb(my_notes) {
    var n = my_notes.length;
    var spacing = (width-n*tine_width)/n;
    
    var x = spacing/2;
    var y = height-tine_length(pitch_to_freq(my_notes[0]));
    var old_y = y;
    var result = CAG.fromPoints([[0,0],[0,y],[x,y],[x,0]]);
    result = result.union(CAG.fromPoints([[x,0],[x,height],[x+tine_width,height],[x+tine_width,0]]));
    //result = union(result,union());
    x+= tine_width;
    
    function tine(x,y,old_y) {
        //echo("making a thing at "+x);
        return base_tine(x,y,old_y).union(CAG.fromPoints([[x,0],[x,height],[x+tine_width,height],[x+ tine_width,0]]));
    }

    function base_tine(x,y,old_y) {
        return CAG.fromPoints([[x-spacing,0],[x-spacing,old_y],[x,y],[x+tine_width,y],[x+tine_width,0]]);
    }
    
    //result = CAG.fromPoints([[0,0],[0,y],[spacing/2,y],[spacing/2,0]]);
    for (var i = 1; i < n; i++) {
        pitch = my_notes[i];
        old_y = y;
        x += spacing;
        y = height-tine_length(pitch_to_freq(pitch));
        result = result.union(tine(x,y,old_y));
        x += tine_width;
    }
    result = result.union(CAG.fromPoints([[x,0],[x,y],[x+spacing/2,y],[x+spacing/2,0]]));
    //result = union(result,CAG.fromPoints([[x,0],[x,y],[x+spacing/2,y],[x+spacing/2,0]]));
    return result;
}

function main() {
    var notes = [41,43,48,52,55,57,60,62,64,65,67,69];
    return make_comb(notes);
}