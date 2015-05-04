import ezdxf
from math import *

#dxf setup
drawing = ezdxf.new(dxfversion='AC1024')
modelspace = drawing.modelspace()
base_drawing = ezdxf.new(dxfversion='AC1024')
base_space = base_drawing.modelspace()

#global variables
#all units in inches
kerf=0.01 #this should be half the thickness if we're using ponoko
width = 3.0
height = 1.25
tine_width = 3.0/64+2*kerf
#spacing = 



def line(space,*args):
    #print ("line from "+str(args[0])+" to "+str(args[1]))
    space.add_line(*args,dxfattribs={'color': 0})

def polyline(space,*args):
    #print ("line through "+str(args))
    space.add_polyline2d(*args,dxfattribs={'color': 0})

def tine_length(frequency):
    thick = .036
    density = .289 #lbs/in3
    Y = 28500000 #young's modulus in ksi
    l=sqrt(.162 * thick / frequency * sqrt(Y/density))
    #print("length of "+str(frequency)+"Hz is "+str(l))
    return l

def pitch_to_freq(pitch):
    return 440*(2.0**((pitch-69.0)/12))

def tine(pitch, x, tine_width):
    y = height-tine_length(pitch_to_freq(pitch))
    polyline(modelspace,[(x,y),(x,height),(x+tine_width,height),(x+tine_width,y)])
    return y

def make_comb(song_notes,name):#song_notes are midi note numbers (C4=60)
    n = len(song_notes);
    notes = sorted(song_notes)
    spacing = (width-n*tine_width)/n

    x = spacing/2
    y = tine(notes[0],x,tine_width)
    min_y = y
    polyline(modelspace,[(spacing/2,y),(0,y),(0,0),(width,0)])
    polyline(base_space,[(tine_width+spacing,y),(0,y),(0,0),(width,0)])
    x += tine_width

    for note in notes[1:]:
        #print "processing "+str(note)
        old_y = y
        old_x = x
        x += spacing
        y = tine(note,x,tine_width)
        line(modelspace,(old_x,old_y),(x,y))
        x += tine_width
        polyline(base_space,[(old_x+spacing/2,old_y),(old_x+spacing/2,y),(x+spacing/2,y)])

    polyline(modelspace,[(width,0),(width,y),(width-spacing/2,y)])
    line(base_space,(width,0),(width,y))

    modelspace.add_circle((width/4,.25),.0669291,{'color': 0})
    modelspace.add_circle((3*width/4,.5),.0669291,{'color': 0})
    base_space.add_circle((width/4,.25),.0669291,{'color': 0})
    base_space.add_circle((3*width/4,.5),.0669291,{'color': 0})
    
    drawing.saveas(str(name)+'_comb.dxf')
    base_drawing.saveas(str(name)+'_base.dxf')

make_comb([59,60,61,62,64,65,66,67,68,69,70,71,72,74,75,76,77,78,79,80,81,82,83,84,85,86],"harry_potter")