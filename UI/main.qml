import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "./components" as Comp

ApplicationWindow {
    visible: true
    width: 800
    height: 500
    title: "Sky viewer"

    property url start_image: "file:///"

    StackView {
        anchors.fill: parent
        initialItem: start_image ? img_start : explrorer_start
    }

    Comp.ImageStart {
        id: img_start
    }

    Comp.ExplorerStart {
        id: explorer_start
    }






}
