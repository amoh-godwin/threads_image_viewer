import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Component {

    Rectangle {

        ColumnLayout {
            anchors.fill: parent

            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 48
                color: "darkgrey"
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

        }

    }

}
