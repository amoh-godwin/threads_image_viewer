import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
    id: root

    property color bgcolor: "#4C4A48"

    background: Rectangle {
        implicitWidth: 128
        implicitHeight: 48
        color: root.hovered ? bgcolor : "transparent"
    }

    contentItem: Text {
        text: root.text
        font: root.font
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color: "white"
    }

}
