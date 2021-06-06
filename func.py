from PyQt5.QtCore import QObject, pyqtSlot, pyqtSignal


class PhotoViewer(QObject):


    def __init__(self, foldername=""):
        super().__init__()

