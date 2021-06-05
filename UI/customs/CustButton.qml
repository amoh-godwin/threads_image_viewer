import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
    id: root

    property color bgcolor: "#4C4A48"

    background: Rectangle {
        implicitWidth: 78
        implicitHeight: 56
        color: "transparent"
    }

    contentItem: Text {
        text: root.text
        font: root.font
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color: root.hovered ? "white" : "transparent"
    }

}
