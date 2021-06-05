import sys

from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine


app = QGuiApplication(sys.argv)

engine = QQmlApplicationEngine()
engine.load('UI/main.qml')
engine.quit.connect(app.quit)

sys.exit(app.exec())
