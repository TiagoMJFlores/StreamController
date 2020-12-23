StreamController
========
StreamController is a controller with the stream it controls. StreamController allows sending data, error and close events on its stream. The public interfaces are inspired by Dart Streams and RxDart.

StreamController...

 * simplifies the communication and decoupling between components
 * facilitates the implementation of architectures such as MVVM
 * simplifies sending error messages in a structured way
 * it is lighweight compared to alternatives that offer streams like RxSwift or ReactiveCocoa
 * have advanced features like Persistent Streams, Stream Transformer and CombineLastest Operators  etc.



How do I use it?
-------------------
1. Define the stream controller:

    ```swift  
   var streamController = StreamController<Int>()
    ```

2. Listen to events and catch errors:

   ```swift  
   streamController.stream.listen { value in
            print("received 1: \(value)")
    }.catchError { value in
            print("throw error: \(value)")
    }   
    ```

3. Post events and errors:

    ```swift  
    streamController.sink.add(1)
    streamControllerNumber.sink.addError("send error")
    ```
4. Closes the stream
```swift  
    streamController.steam.close()
 ```

Add StreamController to your project
----------------------------
(To do)


Advanced Features
----------------------------
<details><summary><strong>PersistentStreamController ( Keep in memory the last value sent to the Stream ) </strong></summary>
<p>
    
1. Declare  PersistentStreamController
```swift
    var persistentStreamController = PersistentStreamController<String>()
```
     
2. Sink values into Stream
```swift
    persistentStreamController.sink.add("PersistentStream first value sent")
    persistentStreamController.sink.add("PersistentStream last value sent. Always stored and waiting to be used")
```
  
 3. Retrieves the last value sent to the stream even if it was sent before being listen
```swift
     persistentStreamController.stream.listen { value in
         print("I am too late for listen values already sent")
     }
        
     if let storedValue = persistentStreamController.value {
        print(storedValue)
     }
```

</details>

<details><summary><strong>StreamTransformer ( Transform a stream into another stream ) </strong></summary>
<p>
    
1. Declare StreamController
```swift
   var streamControllerPassword = StreamController<String>(streamListenType: .multipleListener)
```

2. Define the transformation
```swift
    let streamTransfomer = StreamTransformer<String, Bool>.fromHandlers(
            handlers: { (data: String, sink: EventSink<Bool>) in
                
             if (data.count > 5) {
                sink.add(true)
             } else {
                sink.addError("password too short")
             }  
     })
```

3. Add transform to the Stream using the transform method
```swift
   streamControllerPassword.stream.transform(streamTransformer: streamTransfomer).listen { value in
      print("transform stream: \(value)")
   }.catchError { value in
      print("transform error: \(value)")
  }
        
```
4. Send Events
```swift
    streamControllerPassword.sink.add("d")
    streamControllerPassword.sink.add("valid pasword")
```

 </details>   

<details><summary><strong>CombineLatestStream ( Combines multiple streams into one ) </strong></summary>
<p>


1. Declare StreamControllers that you want to combine
```swift
    var streamControllerNumberOne = StreamController<Int>(streamListenType: .multipleListener)
    var streamControllerNumberTwo = StreamController<Int>(streamListenType: .multipleListener)
```

2. Declare CombineLatestStream
```swift
    let combineLatest = CombineLatestStream<Int>()
```

 3. Combine streams into a new stream and create a new combination with streams
```swift
     combineLatest.combine2(streamA: streamControllerNumberOne.stream, streamB: streamControllerNumberTwo.stream) { (valueA, valueB) -> Int in
         return valueA + valueB
      }.listen(received: { result in
         print("combineLatest stream \(result)")
      })
```

4 Send events to StreamControllers as you normally would
```swift
    let combineLatest = CombineLatestStream<Int>()
```

</p>
</details>

Requirements
------------
iOS 9+
