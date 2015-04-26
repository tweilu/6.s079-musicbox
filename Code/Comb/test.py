import ezdxf
drawing = ezdxf.new(dxfversion='AC1024')
modelspace = drawing.modelspace()
modelspace.add_line((0, 0), (10, 0), dxfattribs={'color': 7})
drawing.layers.create('TEXTLAYER', dxfattribs={'color': 2})
modelspace.add_text('Test', dxfattribs={'insert': (0, 0.2), 'layer': 'TEXTLAYER'})
drawing.saveas('test.dxf')
