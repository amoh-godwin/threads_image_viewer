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

