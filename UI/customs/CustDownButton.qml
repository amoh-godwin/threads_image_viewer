import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
    id: ctrl

    background: Rectangle {
        implicitWidth: 36
        implicitHeight: 25
        color: ctrl.pressed ? Qt.darker('dodgerblue'): ctrl.hovered ? "dodgerblue" : Qt.lighter("#1C1B1B")
        radius: 4
    }

    contentItem: Text {
        text: ctrl.text
        font: ctrl.font
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color: "white"
    }

}
