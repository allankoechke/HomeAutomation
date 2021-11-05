# This Python file uses the following encoding: utf-8
import os
from pathlib import Path
import sys

try:
    from PySide2.QtCore import QObject, Signal, Slot
    from PySide2.QtGui import QGuiApplication
    from PySide2.QtQml import QQmlApplicationEngine

except Exception as err:
    from PyQt5.QtCore import QObject, pyqtSignal as Signal, pyqtSlot as Slot
    from PyQt5.QtGui import QGuiApplication
    from PyQt5.QtQml import QQmlApplicationEngine
    err = err + ""
    print(err)

#import RPi.GPIO as GPIO
#import time

#class HomeAutomation(QObject):
#    brightnessValueChanged = Signal(int)
#    brightnessChangeAllowed = Signal(bool)
#    redLedOn = Signal(bool)
#    greenLedOn = Signal(bool)

#    def __init__(self):
#        self._red_led = 5
#        self._green_led = 6
#        self._brightness_led = 7

#        # Set the board as BroadCom GPIO numbering
#        # GPIO.setmode(GPIO.BCM)

#    def __del__(self):
#        pass

#    @Slot(int)
#    def set_brightness(self, value):
#        pass

#    @Slot(bool)
#    def set_red_led(self, isOn):
#        pass

#    @Slot(bool)
#    def set_green_led(self, isOn):
#        pass

# Entry point of the application
# Loads the GUI QML UI application
if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    engine.load(os.fspath(Path(__file__).resolve().parent / "qml/main.qml"))
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())
