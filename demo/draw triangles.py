from mkernel import Model
from wkernel import Window

"""
draw primitive triangles
"""

class MyWindow(Window):
    def __init__(self):
        super().__init__(500, 500, 'my window 1', monitor=None, shared=None)
        self.framerate = 60
        # enable camera move
        self.devices.cameras[0].tripod.lookat((200, 100, 200), (0, 0, 0), (0, 0, 1))

        # create model
        self.model = Model()
        e = 100
        self.model.add_tgl([0, 0, 0], [e, 0, 0], [0, e, 0]).clr_fill = 1, 0, 0, 1
        self.model.add_tgl([0, 0, 0], [0, e, 0], [0, 0, e]).clr_fill = 0, 1, 0, 1
        self.model.add_tgl([0, 0, 0], [e, 0, 0], [0, 0, e]).clr_fill = 0, 0, 1, 1

    def draw(self, frame_count=None):
        with self.devices.panes[0] as v:
            with self.devices.cameras[0] as c:
                v.clear(.5, .5, .5, 1)
                self.model.render()

MyWindow().run_all()
