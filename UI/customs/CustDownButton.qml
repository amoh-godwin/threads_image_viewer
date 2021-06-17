import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
    id: ctrl

    property color bg_color: Qt.lighter("#1C1B1B")
    property int radius: 4

    background: Rectangle {
        implicitWidth: 36
        implicitHeight: 25
        color: ctrl.pressed ? Qt.darker('dodgerblue'): ctrl.hovered ? "dodgerblue" : ctrl.bg_color
        radius: ctrl.radius
    }

    contentItem: Text {
        text: ctrl.text
        font: ctrl.font
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color: "white"
    }

}
