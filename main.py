import sys
import os

from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine

from func import PhotoViewer


if len(sys.argv) > 1:
    user_file = 'file:///' + os.path.realpath(sys.argv[1])

app = QGuiApplication(sys.argv)

engine = QQmlApplicationEngine()
engine.load('UI/main.qml')
engine.quit.connect(app.quit)

back_end = PhotoViewer()
engine.rootObjects()[0].setProperty('backend', back_end)
engine.rootObjects()[0].setProperty('actual_image', user_file)

sys.exit(app.exec())
