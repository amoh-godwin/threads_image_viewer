import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "./components" as Comp

ApplicationWindow {
    visible: true
    width: 800
    height: 500
    title: "Sky viewer"

    property QtObject backend
    property bool start_image: true
    property url actual_image: ""

    StackView {
        anchors.fill: parent
        initialItem: start_image ? img_start : explorer_start
    }

    Comp.ImageStart {
        id: img_start

        Component.onCompleted: {
            actual_image = "./test/flamingo.jpg"
        }
    }

    Comp.ExplorerStart {
        id: explorer_start
    }


    Connections {
        target: backend

        function onChangeImage(new_file) {
            actual_image = new_file
        }
    }


}
