import os
from collections import deque

from PyQt5.QtCore import QObject, pyqtSlot, pyqtSignal


class PhotoViewer(QObject):


    def __init__(self, currfile=""):
        super().__init__()
        self.curr_file = currfile
        self.curr_index = 0
        self.supported_formats = ['.jpeg', '.jpg', '.png', '.gif']
        self.image_list = deque([])

        self.find_other_images()

    def find_other_images(self) -> None:
        folder = os.path.dirname(self.curr_file)
        mainfile = os.path.split(self.curr_file)[-1]

        conts = os.listdir(folder)

        self.image_list = deque([
            x for x in conts
             if os.path.splitext(x)[-1] in self.supported_formats])

        ind = -1
        for img in self.image_list:
            ind += 1
            if mainfile == img:
                self.curr_index = ind

        print(self.image_list)

