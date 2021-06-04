import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Component {

    Rectangle {
        color: "darkgrey"

        Rectangle {
            id: img_area
            anchors.fill: parent
            color: "transparent"
        }

        Rectangle {
            width: parent.width
            height: 48
            color: "#77000000"
        }

    }

}
