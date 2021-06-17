import QtQuick 2.15
import QtQuick.Controls 2.15

ProgressBar {

    id: ctrl

    background: Rectangle {
        color: "transparent"
        border.color: Qt.lighter("#1C1B1B")
    }

    /*contentItem: Item {
        implicitHeight: 24
        implicitWidth: 128

        Rectangle {
            width: ctrl.visualPosition * parent.width
            height: parent.height
            color: "dodgerblue"
        }

    }*/

}
