import os
from time import sleep
import threading
from collections import deque
import requests
from random import randrange
from time import sleep

from PyQt5.QtCore import QObject, pyqtSlot, pyqtSignal


class PhotoViewer(QObject):


    def __init__(self, currfile: str = ""):
        super().__init__()
        self.curr_file = currfile
        self.curr_index = 0
        self.folder = ""
        self.supported_formats = ['.jpeg', '.jpg', '.png', '.gif']
        self.image_list = deque([])

        self.find_other_images()

    changeImage = pyqtSignal(str, arguments=['change_image'])

    def find_other_images(self) -> None:
        find_thread = threading.Thread(target=self._find_other_images)
        find_thread.daemon = True
        find_thread.start()

    def _find_other_images(self):
        self.folder = os.path.dirname(self.curr_file)
        mainfile = os.path.split(self.curr_file)[-1]

        conts = os.listdir(self.folder)

        self.image_list = deque([
            x for x in conts
             if os.path.splitext(x)[-1] in self.supported_formats])

        ind = -1
        for img in self.image_list:
            ind += 1
            if mainfile == img:
                self.curr_index = ind

    @pyqtSlot(str)
    def get_next_image(self, direction):
        f_thread = threading.Thread(target=self._get_next_image, args=[direction])
        f_thread.daemon = True
        f_thread.start()

    def _get_next_image(self, direction):
        if direction == 'left':
            self.curr_index -= 1
        else:
            self.curr_index += 1

        curr_img = self.image_list[self.curr_index]
        curr_img_path = f'file:///{os.path.join(self.folder, curr_img)}'
        self.changeImage.emit(curr_img_path)


class PhotoDownloader(QObject):


    def __init__(self):
        super().__init__()
        self.image_types_map = {
            'image/gif': ".gif",'image/jpeg': ".jpeg",
            'image/png': ".png",'image/svg+xml': ".svg",
            'image/tiff': ".tiff"}

    passing = pyqtSignal(str, arguments=['passing'])
    downloading = pyqtSignal(bool, arguments=['downloading'])
    progressChanged = pyqtSignal(int, arguments=['progressChanged'])
    downloadComplete = pyqtSignal(str, arguments=['download_complete'])

    @pyqtSlot(str)
    def download(self, filename: str) -> None:
        d_thread = threading.Thread(target=self._download, args=[filename])
        d_thread.daemon = True
        d_thread.start()

    def _download(self, url: str):
        print(f'download received {url}')

        response = requests.get(url, stream=True)

        total_size_in_bytes = int(response.headers.get('content-length', 0))
        cont_type = str(response.headers.get('content-type', 0))
        block_size = 10240
        total_downloaded = 0

        if cont_type in self.image_types_map:
            ext = self.image_types_map[cont_type]
            filename = f"{randrange(1000, 10000)}{ext}"
        else:
            return

        with open(filename, 'wb') as b_file:
            self.downloading.emit(True)
            sleep(0.1)

            try:
                for data in response.iter_content(block_size):
                    total_downloaded += block_size
                    percent = total_downloaded / total_size_in_bytes * 100
                    sleep(0.01)
                    self.progressChanged.emit(percent)
                    b_file.write(data)

                self.downloadComplete.emit(os.path.abspath(filename))
            except:
                print('Something happened. Dowload terminated')

