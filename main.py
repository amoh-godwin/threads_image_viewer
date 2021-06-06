import sys

from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine

from func import PhotoViewer


app = QGuiApplication(sys.argv)

engine = QQmlApplicationEngine()
engine.load('UI/main.qml')
engine.quit.connect(app.quit)

back_end = PhotoViewer()
engine.rootObjects()[0].setProperty('backend', back_end)

sys.exit(app.exec())
