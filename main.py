# This Python file uses the following encoding: utf-8
import os
from pathlib import Path
import sys

try:
    from PySide2.QtCore import QObject, Slot
    from PySide2.QtGui import QGuiApplication
    from PySide2.QtQml import QQmlApplicationEngine

except Exception as err:
    from PyQt5.QtCore import QObject, pyqtSlot as Slot
    from PyQt5.QtGui import QGuiApplication
    from PyQt5.QtQml import QQmlApplicationEngine
    err = err

# SET GPIO PINS
LED_RED = 27
LED_GREEN = 23
LED_YELLOW = 19
FAN_PIN = 24

'''
Raspberry Pi comes with RPi.GPIO Library which is not usable on
desktop machines where I do my tests and developement. So, to allow
me to develop on my laptop, I have added two classes below (DummyPWM and
DummyGPIO) that have all functions the Raspberry Pi GPIO library has.

These classes are loaded if loading of the RPi.GPIO modules fail
'''


# Dummy PWM Class
class DummyPWM:
    def start(self, x):
        pass

    def ChangeDutyCycle(self, value):
        pass


# Dummy GPIO Class
class DummyGPIO:
    BCM = ""
    IN = ""
    OUT = ""
    HIGH = 1
    LOW = 0

    def __init__(self):
        pass

    def setup(seld, x, y):
        pass

    def setmode(self, v):
        pass

    def output(self, p, v):
        pass

    def input(self, p):
        pass

    def PWM(self, p, f):
        return DummyPWM()

    def cleanup(self):
        pass


try:
    import RPi.GPIO as GPIO
except Exception as e:
    GPIO = DummyGPIO()  # Dummy GPIO functions to enable testing UI on dekstops
    e = e


class HomeAutomation(QObject):
    def __init__(self):
        super().__init__()

        # Set the board as BroadCom GPIO numbering
        GPIO.setmode(GPIO.BCM)

        # Set Pins as Output gpios
        GPIO.setup(LED_GREEN, GPIO.OUT)
        GPIO.setup(LED_RED, GPIO.OUT)
        GPIO.setup(LED_YELLOW, GPIO.OUT)
        GPIO.setup(FAN_PIN, GPIO.OUT)

        # Setup PWM Pin
        self.pwm = GPIO.PWM(LED_YELLOW, 100)  # 100 Hz
        self.pwm.start(0)

    def __del__(self):
        GPIO.cleanup()
        print("Cleaning up, exitting ...")

    @Slot(int)
    def set_brightness(self, value):
        # Set Duty Cycle
        self.pwm.ChangeDutyCycle(value)
        print(f"PWM Duty Cycle set to {value}%")

    @Slot(bool)
    def set_yellow_led(self, isOn):
        self.pwm.ChangeDutyCycle(0)
        print("Turning off YELLOW LED")

    @Slot(bool)
    def set_red_led(self, isOn):
        if isOn:
            GPIO.output(LED_RED, GPIO.HIGH)
            print("RED LED SET HIGH")
        else:
            GPIO.output(LED_RED, GPIO.LOW)
            print("RED LED SET LOW")

    @Slot(bool)
    def set_green_led(self, isOn):
        if isOn:
            GPIO.output(LED_GREEN, GPIO.HIGH)
            print("GREEN LED SET HIGH")
        else:
            GPIO.output(LED_GREEN, GPIO.LOW)
            print("GREEN LED SET LOW")

    @Slot(bool)
    def set_fan_on(self, isOn):
        if isOn:
            GPIO.output(FAN_PIN, GPIO.HIGH)
            print("Fan Pin SET HIGH")
        else:
            GPIO.output(FAN_PIN, GPIO.LOW)
            print("Fan Pin SET LOW")


# Entry point of the application
# Loads the GUI QML UI application
if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    ha = HomeAutomation()
    engine.rootContext().setContextProperty("backend", ha)

    engine.load(os.fspath(Path(__file__).resolve().parent / "qml/main.qml"))
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())
