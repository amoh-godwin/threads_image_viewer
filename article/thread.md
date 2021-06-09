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
		- test
		- main.qml
	- main.py

```

You can see from the structure above that **UI** is a folder within **threaded_image_viewer** folder and that **test** is also a folder within **UI**



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
    	id: switch_buttons_cont
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

The Rectangle that handles the navbar has been given the id: navbar ( not necessary, you can ignore) and a color of black with 77% opacity. The Rectangle that handles the actual image area has and id: **img_area** and  a transparent color, because the app background already has a color of **#1C1B1B**.



Next put the Image type that will be used to render the image that the user wants

```QML
...
Rectangle {
    id: img_area
    ...
    
    Image {
        source: "path/to/some/image"
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
    }
    
}
...
```



Put some image in the test folder that we created above, to test the layout of the image. 

```QML
...
source: "./test/some_image.jpg"
...
```



The anchors.fill: parent and the fillMode: Image.PreserveAspectFit are the ones controling the dimensions of the image. We will need this because:

 1. The user can change the image size at anytime either through a zoom button or by resizing the window itself.

 2. The user should see the entirety of the image is there is no zooming. If the image is tall the entirety will be shown as so, if its equal on both ends, it will be shown as so.

    

***



We will need a property to hold the source of the image because the source will be varied, in this case, the user will press buttons to change it. We will create a property of type `url` and call it `actual_image`

```QML
...
title: "Sky viewer"

property url actual_image: "./test/some_image.jpg"

...
```

You could have used a `string` as the type for the source but a `url` is the best suited type for a file path.

Now we will use it as the source of the Image type

```QML
...

    ...

    Image {
        source: actual_image  // used to be "path/to/some/image"
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
    }

...
```



We would need to create the buttons that will be used to switch between images.

Inside the RowLayout with id: `switch_buttons_cont`, will we put these buttons.



```QML
...
RowLayout {
    id: switch_buttons_cont
    ...
    
    Button {
    	text: "<"
    }
    
    Button {
    	Layout.alignment: Qt.AlignRight
    	text: ">"
    }
    
}
...
```

You can see that we have ordinary buttons and that the second one has been aligned to the right side. But we would have to customise the buttons a bit.

Create a new folder named 'customs' and a new file named 'CustButton.qml', so that the new structure is like shown below:

```
- theaded_image_viewer
	- UI
		- customs
			- CustButton.qml
		- test
		- main.qml
	- main.py
```

Open up CustButton.qml and write the import statements and normal button codes.

```QML
import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
	id: ctrl
}
```

Next customise the background and the contentItem properties

```QML
...
Button {
	id: ctrl
	
	background: Rectangle {
        implicitWidth: 78
        implicitHeight: 56
        color: ctrl.hovered ? "#50ffffff": "transparent"
    }

    contentItem: Text {
        text: ctrl.text
        font: ctrl.font
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color: ctrl.hovered ? "white" : "transparent"
    }
	
}
```

Save the file so that now. The full contents of the CustButton.qml is:

```QML
import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
	id: ctrl

	background: Rectangle {
        implicitWidth: 78
        implicitHeight: 56
        color: ctrl.hovered ? "#50ffffff": "transparent"
    }

    contentItem: Text {
        text: ctrl.text
        font: ctrl.font
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color: ctrl.hovered ? "white" : "transparent"
    }

}

```

Now inside the main.qml import the CustButton.qml. You do this by importing the parent folder and creating a namespace out of it.

```QML
...
import QtQuick.Layouts 1.15
import "../customs" as Cust

...
```

The namespace Cust can then be used to access the **CustButton.qml**.

In the `RowLayout` with `id: switch_buttons_cont`. change the Buttons to `CustButtons`.

```QML
...
RowLayout {
    id: switch_buttons_cont
    ...

    Cust.CustButton {
    	text: "<"
    }
    
    Cust.CustButton {
    	Layout.alignment: Qt.AlignRight
    	text: ">"
    }
    
}
...
```



