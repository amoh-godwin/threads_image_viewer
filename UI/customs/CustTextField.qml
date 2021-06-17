import QtQuick 2.15
import QtQuick.Controls 2.15

TextField {
    id: ctrl
    color: "white"
    placeholderText: "Enter Url"

    background: Rectangle {
        implicitWidth: 128
        color: "transparent"
        border.color: ctrl.activeFocus ? "dodgerblue" : Qt.lighter("#1C1B1B")
        radius: 4
    }

}
