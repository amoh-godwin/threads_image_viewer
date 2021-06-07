import os
from sys import argv
from time import sleep
import threading
from collections import deque

from PyQt5.QtCore import QObject, pyqtSlot, pyqtSignal


class PhotoViewer(QObject):


    def __init__(self, currfile=""):
        super().__init__()
        self.curr_index = 0
        self.curr_img = ""
        self.folder = ""
        self.supported_formats = ['.jpeg', '.jpg', '.png', '.gif']
        self.image_list = deque([])

        self.find_other_images(currfile)

    changeImage = pyqtSignal(str, arguments=['change_image'])

    def find_other_images(self, curr_file) -> None:
        f_thread = threading.Thread(target=self._find_other_images, args=[curr_file])
        f_thread.daemon = True
        f_thread.start()

    def _find_other_images(self, curr_file):

        self.folder = os.path.dirname(curr_file)
        mainfile = os.path.split(curr_file)[-1]

        conts = os.listdir(self.folder)

        self.image_list = deque([
            x for x in conts
             if os.path.splitext(x)[-1] in self.supported_formats])

        ind = -1
        for img in self.image_list:
            ind += 1
            if mainfile == img:
                self.curr_index = ind

        print(self.curr_index)

    @pyqtSlot(str)
    def get_next_image(self, direction):

        if direction == 'left':
            self.curr_index -= 1
        else:
            self.curr_index += 1

        curr_img = self.image_list[self.curr_index]
        self.curr_img = f'file:///{os.path.join(self.folder, curr_img)}'
        self.change_image()

    def change_image(self):
        self.changeImage.emit(self.curr_img)

