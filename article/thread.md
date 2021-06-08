# Threading PyQt5/Qml Applications

Threading is such an important topic in GUI application development without that your app is gonna freeze. And yet python native threading system make it so easy. Qt comes with its on threading system. I think that where in there is a standard library that can handle a task, you shouldn't use a third-party library. This tutorial will discuss threading in python which is also how threading in Qml is done.



## Design the UI

First off we need to design the UI that we are going to use to illustrate this.



### Create folders

Create a folder for the application, call it anything you like. I will call it, **threaded_image_viewer**. As the name suggest its going to be an Image Viewing app. For those of us on Windows 10, the Photos app is really slow to start up so if you are like us, maybe one day, you might want to replace the default Photos app with your own Image Viewing app and you might even ship it for the world. 

The folder structure should look something similar to the structure below.
```
- theaded_image_viewer
	- UI
		- main.qml
	- main.py

```

You can see from the structure above that **UI** is a folder within **threaded_image_viewer** folder



Next open up the main.qml and write the script for a basic window

```QML
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    visible: true
    width: 800
    height: 500
    title: "Sky viewer"
    
}
```

I am sure you already know what the above code does. It creates a window with a title **Sky viewer**.

Next we add a Rectangle which will essentially be a background. We haven't discussed layouts yet, but its not complex. You will understand it usage by practicing with it. So inside the Rectangle we add a ColumnLayout and a RowLayout on top of the ColumnLayout. The RowLayout would hold the left and right button that will be used to switch between images in the same folder.

NB: The three dots (**...**) represents already existing code.



```QML
...
title: "Sky viewer"

Rectangle {
    anchors.fill: parent
    color: "#1C1B1B"

    ColumnLayout {
        anchors.fill: parent
        spacing: 0
    }
    
    RowLayout {
        anchors.centerIn: parent
        width: parent.width
        height: 56
    }

}

...
```

A little not about ColumnLayout and RowLayout is ColumnLayout gives you a column and all the items in there are laid-out as rows whiles a RowLayout gives you a Row and All the items in there are laid-out as columns.



Next, inside the ColumnLayout that will be the main Image area. We will have two Rectangles, one on top acting as some kind of nav bar and another for the actual Image below that Nav bar.



```QML
...

ColumnLayout {
	...
	
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
    }

}
...
```

The Rectangle that handles the navbar has been given the id: navbar ( not necessary, you can ignore) and a color of black with 77% opacity. The Rectangle that handles the actual image area has and id: img_area and  a transparent color, because the app background already has a color of #1C1B1B.