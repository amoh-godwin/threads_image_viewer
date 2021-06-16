import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "./components" as Comp
import "./customs" as Cust

ApplicationWindow {
    visible: true
    width: 800
    height: 500
    title: "Sky viewer"

    property QtObject backend
    property url actual_image: ""

    Rectangle {
        anchors.fill: parent
        color: "#1C1B1B"

        ColumnLayout {
            anchors.fill: parent
            spacing: 0

            Rectangle {
                id: navbar
                Layout.fillWidth: true
                Layout.preferredHeight: 48
                color: "#77000000"

            }

            Rectangle {
                id: img_area
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "transparent"

                Image {
                    source: actual_image
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectFit

                }

            }

        }

        RowLayout {
            id: switch_buttons_cont
            anchors.centerIn: parent
            width: parent.width
            height: 56

            Cust.CustButton {
                text: "<"

                onClicked: backend.get_next_image('left')

            }

            Cust.CustButton {
                Layout.alignment: Qt.AlignRight
                text: ">"

                onClicked: backend.get_next_image('right')

            }



        }


    }


    Connections {
        target: backend

        function onChangeImage(new_file) {
            actual_image = new_file
        }
    }


}
