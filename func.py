import os
from collections import deque

from PyQt5.QtCore import QObject, pyqtSlot, pyqtSignal


class PhotoViewer(QObject):


    def __init__(self, currfile=""):
        super().__init__()
        self.curr_file = currfile
        self.supported_formats = ['.jpeg', '.jpg', '.png', '.gif']
        self.image_list = deque([])

        self.find_other_images()

    def find_other_images(self) -> None:
        folder = os.path.realpath(self.curr_file)
        mainfile = os.path.split(self.curr_file)[-1]

        conts = os.listdir(folder)

        self.image_list = deque([
            x for x in conts
             if os.path.splitext(x)[-1] in self.supported_formats])


