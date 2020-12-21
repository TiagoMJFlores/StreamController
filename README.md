StreamController
========
StreamController is a controller with the stream it controls. StreamController allows sending data, error and close events on its stream.

StreamController...

 * simplifies the communication and decoupling between components
 * facilitates the implementation of architectures such as MVVM
 * simplifies sending error messages in a structured way
 * it is lighweight compared to alternatives that offer streams like Rx
 * has advanced features like Persistent Streams etc.



How do I use it?
-------------------
1. Define the stream controller:

    ```swift  
   var streamController = StreamController<Int>()
    ```

2. Listen to events:

   ```swift  
   streamController.stream.listen { value in
            print("received 1: \(value)")
    }   
    ```

3. Post events:

    ```swift  
    streamController.sink.add(1)
    ```

Add StreamController to your project
----------------------------
(To do)

Requirements
------------
iOS 9+
