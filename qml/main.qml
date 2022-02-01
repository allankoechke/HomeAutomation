import QtQuick 2.4
import QtQuick.Window 2.2
import QtQuick.Controls 2.4

// Import the backend
// import ke.lalan 1.0

Window {
    id: app
    width: 800
    height: 480
    visible: true
    flags: Qt.FramelessWindowHint
    visibility: "FullScreen"
    title: qsTr("Home Automation Project")


    property bool isFanRunning: true
    property bool isLightsRedOn: true
    property bool isLightsGreenOn: true
    property real brightnessValue: 56
    property bool isDimmingLightsAllowed: true

    onIsFanRunningChanged: {
        backend.set_fan_on(isFanRunning)
    }

    onIsLightsRedOnChanged: {
        backend.set_red_led(isLightsRedOn)
    }

    onIsLightsGreenOnChanged: {
        backend.set_green_led(isLightsGreenOn)
    }

    onIsDimmingLightsAllowedChanged: {
        backend.set_yellow_led(true)
    }

    onBrightnessValueChanged: {
        if (isDimmingLightsAllowed){
            backend.set_brightness(brightnessValue)
        }
    }

    // onCompleted, set the default GPIO pins state
    Component.onCompleted: {
        backend.set_fan_on(isFanRunning)

        backend.set_red_led(isLightsRedOn)

        backend.set_green_led(isLightsGreenOn)

        backend.set_yellow_led(true)

        if (isDimmingLightsAllowed){
            backend.set_brightness(brightnessValue)
        }
    }

    // Set the background image
    Image {
        source: Qt.resolvedUrl("../assets/images/5577112.jpg")
        fillMode: Image.PreserveAspectCrop
        anchors.fill: parent

        Item {
            anchors.fill: parent

            // Give a 50% opacity black background
            Rectangle {
                color: Qt.rgba(0,0,0,0.5)
                height: 80
                anchors.fill: parent

                Item {
                    height: 70
                    width: parent.width
                    anchors.top: parent.top

                    Rectangle {
                        color: "#fff"
                        height: 1
                        width: parent.width
                        anchors.bottom: parent.bottom
                    }

                    Text {
                        text: qsTr("Home Automation System - 1.0")
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        color: "#fff"
                        font.pixelSize: 24
                        font.bold: true
                    }

                    Image {
                        height: 40
                        visible: false
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: 20
                        source: Qt.resolvedUrl("../assets/images/ieee-ku-white.png")
                        fillMode: Image.PreserveAspectFit
                    }
                }

                Item {
                    anchors.fill: parent
                    anchors.leftMargin: 30
                    anchors.rightMargin: 30
                    anchors.topMargin: 90
                    anchors.bottomMargin: 20

                    Row {
                        anchors.fill: parent
                        spacing: 10

                        Item {
                            height: parent.height
                            width: parent.width * 1/3

                            Column {
                                anchors.fill: parent
                                spacing: 10

                                Rectangle {
                                    id: fanImageRect
                                    color: Qt.rgba(0,0,0,0.5)
                                    radius: 10
                                    width: parent.width
                                    height: parent.height * 2/3 - 5

                                    Column {
                                        anchors.centerIn: parent
                                        spacing: 5

                                        Image {
                                            id: fanImage
                                            source: Qt.resolvedUrl("../assets/images/fan.png")
                                            width: fanImageRect.width > fanImageRect.height ? 0.7 * fanImageRect.height:0.7 * fanImageRect.width
                                            fillMode: Image.PreserveAspectFit
                                            anchors.horizontalCenter: parent.horizontalCenter
                                        }

                                        Item {
                                            width: fanImageRect.width * 0.8
                                            height: 40

                                            Text {
                                                font.bold: true
                                                font.pixelSize: 18
                                                text: qsTr("FAN")
                                                color: "#fff"
                                                anchors.verticalCenter: parent.verticalCenter
                                                anchors.left: parent.left
                                            }

                                            Switch {
                                                anchors.verticalCenter: parent.verticalCenter
                                                anchors.right: parent.right

                                                Component.onCompleted: checked=isFanRunning
                                                onClicked: {
                                                    isFanRunning=checked

                                                    if(checked) {
                                                        console.log("Fan switched ON!")
                                                    } else {
                                                        console.log("Fan switched OFF!")
                                                    }
                                                }
                                            }
                                        }

                                    }
                                }

                                Rectangle {
                                    color: Qt.rgba(0,0,0,0.5)
                                    radius: 10
                                    width: parent.width
                                    height: parent.height * 1/3 - 5

                                    Column {
                                        anchors.centerIn: parent
                                        spacing: 5

                                        Item {
                                            width: fanImageRect.width * 0.8
                                            height: 40

                                            Text {
                                                font.bold: true
                                                font.pixelSize: 18
                                                text: qsTr("LIGHTS RED")
                                                color: "#fff"
                                                anchors.verticalCenter: parent.verticalCenter
                                                anchors.left: parent.left
                                            }

                                            Switch {
                                                anchors.verticalCenter: parent.verticalCenter
                                                anchors.right: parent.right

                                                Component.onCompleted: checked=isLightsRedOn
                                                onClicked: {
                                                    isLightsRedOn=checked

                                                    if(checked) {
                                                        console.log("Red Lights ON!")
                                                    } else {
                                                        console.log("Red Lights OFF!")
                                                    }
                                                }
                                            }
                                        }

                                        Item {
                                            width: fanImageRect.width * 0.8
                                            height: 40

                                            Text {
                                                font.bold: true
                                                font.pixelSize: 18
                                                text: qsTr("LIGHTS GREEN")
                                                color: "#fff"
                                                anchors.verticalCenter: parent.verticalCenter
                                                anchors.left: parent.left
                                            }

                                            Switch {
                                                anchors.verticalCenter: parent.verticalCenter
                                                anchors.right: parent.right

                                                Component.onCompleted: checked=isLightsGreenOn
                                                onClicked: {
                                                    isLightsGreenOn=checked

                                                    if(checked) {
                                                        console.log("Green Lights ON!")
                                                    } else {
                                                        console.log("Green Lights OFF!")
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }

                        Rectangle {
                            id: rightContentRect
                            color: Qt.rgba(0,0,0,0.5)
                            radius: 10
                            width: parent.width * 2/3
                            height: parent.height

                            Switch {
                                anchors.top: parent.top
                                anchors.topMargin: 10
                                anchors.rightMargin: 10
                                anchors.right: parent.right

                                Component.onCompleted: checked=isDimmingLightsAllowed
                                onClicked: {
                                    isDimmingLightsAllowed=checked

                                    if(checked) {
                                        console.log("Dimming Lights Allowed!")
                                    } else {
                                        console.log("Dimming Lights Disallowed!")
                                    }
                                }
                            }

                            Column {
                                anchors.centerIn: parent
                                spacing: 10
                                enabled: isDimmingLightsAllowed

                                CircularProgressBar {
                                    id: progress1
                                    lineWidth: 15
                                    size: rightContentRect.width * 0.5
                                    value: brightnessValue/100
                                    secondaryColor: Qt.rgba(0,0,0,0.4) // "#e0e0e0"
                                    primaryColor: "#29b6f6"
                                    anchors.horizontalCenter: parent.horizontalCenter

                                    Column {
                                        anchors.centerIn: parent
                                        spacing: 5

                                        Text {
                                            text: parseInt(progress1.value * 100) + "%"
                                            font.pointSize: 0.15 * progress1.size
                                            color: progress1.primaryColor
                                        }
                                        Text {
                                            text: qsTr("Brightness")
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            font.pixelSize: 18
                                            color: progress1.primaryColor
                                        }
                                    }
                                }

                                HSlider {
                                    from: 0
                                    to: 100
                                    value: brightnessValue
                                    anchors.horizontalCenter: parent.horizontalCenter

                                    onValueChanged: if(isDimmingLightsAllowed) brightnessValue=value
                                }

                                Text {
                                    text: qsTr("Move the slider to adjust the bulb brightness")
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    font.pixelSize: 14
                                    color: "grey"
                                }
                            }
                        }
                    }
                }
            }
        }
    } // Image

    // Rotation Animation for the Fan
    RotationAnimation {
        target: fanImage
        from: 0; to: 360
        duration: 600
        running: isFanRunning
        loops: RotationAnimation.Infinite
        onRunningChanged: if(!running) target.rotation=0
    }
}
