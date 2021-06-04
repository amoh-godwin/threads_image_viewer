import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    visible: true
    width: 800
    height: 500
    title: "Sky viewer"

    property url start_image: ""

    StackView {
        anchors.fill: parent
        initialItem: start_image ? img_start : browser_start
    }

    Comp.ImageStart {
        id: img_start
    }




}
