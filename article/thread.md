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
import "./customs" as Cust

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



Currently the main.qml file looks like:

```QML
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "./customs" as Cust

ApplicationWindow {
    visible: true
    width: 800
    height: 500
    title: "Sky viewer"
    
    property url actual_image: "./test/some_image.jpg"
    
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
                source: actual_image  // used to be "path/to/some/image"
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
        
        Button {
            text: "<"
        }

        Button {
            Layout.alignment: Qt.AlignRight
            text: ">"
        }
        
    }
    
    
}
```



Now the Design is done



## Connect the Python



Open the main.py file and start a Application from there



```python
import sys

from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine


app = QGuiApplication(sys.argv)

engine = QQmlApplicationEngine()
engine.load('UI/main.qml')
engine.quit.connect(app.quit)

sys.exit(app.exec())

```

Change directory into the project folder

```shell
$ cd H:/Desktop/threaded_image_viewer
```

should give

```shell
H:/Desktop/threaded_image_viewer$
```



Run it by doing

```shell
$ python main.py
```



Now the app starts all is well.



If you open an image, the OS calls the Image viewing app by passing the image's url as a command line argument or parameter as

```shell
$ path/to/image_viewer_app.exe C:/path/to/image.jpeg
```

So your app knows what image your showing from the command line argument.



Lets handle command line arguments.



```python
import sys
import os

...
from PyQt5.QtQml import QQmlApplicationEngine


if len(sys.argv) > 1:
    real_path = os.path.realpath(sys.argv[1])
    user_file = 'file:///' + real_path

...

```

`sys.argv` actually holds all the command line arguments passed to the application. Its a list and always the  first item is the full path the current file we are running, and not the user supplied arguments. In this case, the first item would be: **path/to/main.py**. So we check if there is more than one items, meaning the user did pass arguments to the application. You can see we are getting the real path out user supplied argument, just in case it was a relative path. Next we prepend it with a file protocol **(file:///)** , it could have also been and http protocol **(http://)**. When using full paths in QML, drive letters (**H:/**, **C**:/, **D:/**) confuses the system, so you have to prepend it with the file protocol (**file:///**).

Next we set that to the value of the `actual_image` QML property, so that the app starts showing the users image. It is also time to make the property empty by default

```QML
property url actual_image: ""
```



```python

...
engine.quit.connect(app.quit)
engine.rootObjects()[0].setProperty('actual_image', user_file)

...
```

Now you should run the file with a command line argument

```shell
$ python main.py ./test/some_image.jpg
```

You should see a beautiful image.



Now what we really want to do for our threading illustration is that. Most image viewer apps have next and previous buttons that allow you to see other pictures also in the same folder. This is why we added the buttons in `id: switch_buttons_cont`

Lets create a subclass of QObject like we did for the clock.

Create a file by main.py and name it func.py.

So the new structure looks something similar to this:

```
- theaded_image_viewer
	- UI
		- customs
			- CustButton.qml
		- test
		- main.qml
	- main.py
	- func.py
```



Inside func.py subclass QObject and call it PhotoViewer



```python
from PyQt5.QtCore import QObject


class PhotoViewer(QObject):


    def __init__(self):
        super().__init__()

```

We are calling the `super().__init__()` instead of `QObject().__init__(self)`. The super() way is best.



Before we add any methods to it. Lets import it into the main and send it over to QML as a property.



```python
...
from PyQt5.QtQml import QQmlApplicationEngine

from func import PhotoViewer


if len(sys.argv) > 1:
...
engine.quit.connect(app.quit)

back_end = PhotoViewer()
engine.rootObjects()[0].setProperty('actual_image', user_file)

...
```



Create a QML property backend that will receive the back_end object.

```QML
...
title: "Sky viewer"

property QtObject backend
property url actual_image: ""
...
```



Now set the back_end python object to the backend QML property

```QML
...

back_end = PhotoViewer()
engine.rootObjects()[0].setProperty('backend', back_end)
engine.rootObjects()[0].setProperty('actual_image', user_file)

...
```

All should be well if you should run this.



Now inside our PhotoViewer class we should be crawling the parent folder the image the user wants to see.

```python
import os
from collections import deque

from PyQt5.QtCore import QObject


class PhotoViewer(QObject):


    def __init__(self, currfile: str = ""):
        super().__init__()
        self.curr_file = currfile
        self.curr_index = 0
        self.folder = ""
        self.supported_formats = ['.jpeg', '.jpg', '.png', '.gif']
        self.image_list = deque([])

        self.find_other_images()

	def find_other_images(self) -> None:

        self.folder = os.path.dirname(self.curr_file)
        mainfile = os.path.split(self.curr_file)[-1]

        conts = os.listdir(self.folder)

        self.image_list = deque([
            x for x in conts
             if os.path.splitext(x)[-1] in self.supported_formats])

        ind = -1
        for img in self.image_list:
            ind += 1
            if mainfile == img:
                self.curr_index = ind


```



First of before we are able to crawl the parent folder, the class will have to get access to the filename or the folder name. We pass the filename to it, when we initialise it,

hence the code: 
```python
def __init__(self, currfile: str = ""):
```

Notice we are using annotations, so without the annotations the code could have been written as:

```python
def __init__(self, currfile = ""):
```

Also notice that the `self.image_list` is using the deque (pronounced: deck)  advanced type instead of the base list type. This is because the default list doesn't store items according to any particular order and when you keep appending to it on the fly, the indexing begins to misbehave. I recently run into trouble with it, and now I am a fan of the deque type from the collections module.

When it comes to the find_other_images function:

Again you can see, that we are using annotations, the function declaration could have been written as

```python
def find_other_images(self):
```



 Also the,

```python
self.image_list = deque([
    x for x in conts
     if os.path.splitext(x)[-1] in self.supported_formats])
```

list comprehension is actually looking for files whose file extension match one of the items in the `self.supported_formats`, essentially we are looking for images. You can add to it, but here is a list of supported image formats for the QML Image type.

The code beginning from:

```python
ind = -1
for img in self.image_list:
```

is actually getting the index of the file the user asked to be shown, this will be used to control images that will be shown as the next and previous images of the user's image when those buttons are clicked.

Did you notice that we are running the `find_other_images` function in the `__init__` , from the line:

```python
self.find_other_images()
```



Now in the main.py, pass the real_path to the class when we call it.

```python
...

back_end = PhotoViewer(currfile=real_path)
engine.rootObjects()[0].setProperty('backend', back_end)
...
```



In most instances, the image might be in a folder that has many other images or files, and that will slow down the time it takes for the UI to be fully ready (even though list comprehensions are fast), it will freeze between the time the `engine.load('UI/main.qml')` was run till the time `back_end = PhotoViewer(currfile=real_path)` is done with the initialization. That will cause our now white UI to be unresponsive for sometime.

*show image*



To show this try using an image you have say in the Downloads folder.

```shell
$ python main.py C:/Users/user_name/Downloads/some_image.jpg
```



In other for our app to be build for all user cases, we should presume that some user somewhere have such a folder with so many files, from where he will call our application to show his image.

It simple, lets experiment with the sleep function.

Sleep on the `find_other_images` function for 2 seconds, see what happens to the UI.

```python
import os
from time import sleep
...

	...

	def find_other_images(self) -> None:
        ...
        self.image_list = deque([
    		x for x in conts
     		 if os.path.splitext(x)[-1] in self.supported_formats])
        
        sleep(2)
        
        ...

```

The UI will freeze for at least 2 seconds. Imagine what the user will feel about his system specs. But is not entirely the reason why the UI is slow, is partly due to the fact that we are not using Threads, for something that threads should handle.

So enter in, Threads.

Threads can handle tasks concurrently. So we initialize and object and move on to complete the UI, all whiles we are crawling the parent folder of the image in the background.

Python has sufficient threading functions, Qt also has threading functions. read more on that here. We will use native python threading in this tutorial.

How you use threading is that you call the Thread object, you tell it the function you want to run and the parameters with which it should run and the Thread object call the function for you in its own thread.

So lets get to it.



```python
...
from time import sleep
import threading
...

class PhotoViewer(QObject):


    def __init__(self, currfile: str = ""):
        super().__init__()
        ...
        self.find_other_images()

    def find_other_images(self) -> None:
        find_thread = threading.Thread(target=self._find_other_images)
        find_thread.daemon = True
        find_thread.start()

    def _find_other_images(self):

        self.folder = os.path.dirname(self.curr_file)
        mainfile = os.path.split(self.curr_file)[-1]

        ...

        sleep(2)
        
        ...

```



From the above code, you can see that we now have two seemingly identical methods, one is an underscore function or method. The underscore function is used to discourage people from calling it directly, it always shows up at the bottom of autocompletion dialog boxes. The underscore method is the one that is doing the old job of the find_other_images method. We could have used a completely different name without underscores, but for pragmatics sake, we used an underscore method. and in the `find_other_images` method we are calling the Thread object and telling which method to run in a thread with the line

```python
find_thread = threading.Thread(target=self._find_other_images)
```

the `find_thread.daemon = True` code makes sure that when the main thread the created this thread has terminated, this newly created thread should also terminate. This is some really important code, in the world of threading, especially if you would have a forever loop run in a threaded method or function. The line:

```pyton
find_thread.start()
```

is what actually starts your method.



You can see that we are still calling the `self.find_other_images` method in the `__init__`. Because that is what we want, we don't want to call the underscore method it will create the same problem as before.

Any method the `self.find_other_images`, will have it return immediately thinking it is done with its job, not knowing it started a thread for a method and that that method is running in the background. That way, the code doesn't have to wait for the method to be complete, because, it thinks that the method has completed.



Now run it again and the 2 seconds delay is gone, even the sleep code is still there.