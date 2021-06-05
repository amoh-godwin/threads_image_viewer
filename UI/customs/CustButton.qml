import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
    id: root

    property color bgcolor: "darkgrey"

    background: Rectangle {
        implicitWidth: 128
        implicitHeight: 48
        color: bgcolor
    }

    contentItem: Text {
        text: root.text
        font: root.font
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color: "white"
    }

}
