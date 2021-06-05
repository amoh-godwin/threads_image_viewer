import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../customs" as Cust

Component {

    Rectangle {
        id: root
        color: "darkgrey"

        ColumnLayout {
            anchors.fill: parent
            spacing: 0

            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 48
                color: "#77000000"

                Cust.CustButton {
                    anchors.right: parent.right
                    text: "Lookup"
                }

            }

            Rectangle {
                id: img_area
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "transparent"

                Image {
                    source: start_image
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectFit
                }

            }

        }

    }


}
