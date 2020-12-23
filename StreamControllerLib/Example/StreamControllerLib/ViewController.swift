//
//  ViewController.swift
//  StreamControllerLib
//
//  Created by tiagoflores2@outlook.com on 12/16/2020.
//  Copyright (c) 2020 tiagoflores2@outlook.com. All rights reserved.
//

import UIKit
import StreamControllerLib

final class ViewController: UIViewController {

    var streamControllerNumber = StreamController<Int>(streamListenType: .multipleListener)
    var streamControllerNumberTwo = StreamController<Int>(streamListenType: .multipleListener)
    var streamControllerPassword = StreamController<String>(streamListenType: .multipleListener)
    let combineLatest = CombineLatestStream<Int>()

    var persistentStreamController = PersistentStreamController<String>()
   
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        /*
        streamControllerNumber.stream.listen { value in
            print("received 1: \(value)")
        }
        
        streamControllerNumber.stream.listen { value in
            print("received 2: \(value)")
        }.catchError { value in
            print("throw error: \(value)")
        }
    
        streamControllerNumber.sink.add(2)
        streamControllerNumber.sink.addError("send error")
        
        streamControllerNumber.sink.close()
        streamControllerNumber.stream.listen { value in
            print("this should fail: \(value)")
        }
        */

        combineLatest.combine2(streamA: streamControllerNumber.stream, streamB: streamControllerNumberTwo.stream) { (valueA, valueB) -> Int in
            return valueA + valueB
        }.listen(received: { result in
            print("combineLatest stream \(result)")
        })
        
        /*
        streamControllerNumber.sink.add(1)
        streamControllerNumberTwo.sink.add(2)
        streamControllerNumber.sink.add(1)
        streamControllerNumberTwo.sink.add(2)*/
        transformerTest()
    }
    
    
    func persistentStreamTest() {
         persistentStreamController.sink.add("PersistentStream first value sent")
         persistentStreamController.sink.add("PersistentStream last value sent. Always stored and waiting to be used")
         
         persistentStreamController.stream.listen { value in
             print("I am too late for listen values already sent")
         }
        
         if let storedValue = persistentStreamController.value {
             print(storedValue)
         }
    }
    
    func transformerTest() {
        let streamTransfomer = StreamTransformer<String, Bool>.fromHandlers(
            handlers: { (data: String, sink: EventSink<Bool>) in
                
                if (data.count > 5) {
                    sink.add(true)
                } else {
                    sink.addError("password too short")
                }
               
            })
        
        streamControllerPassword.stream.transform(streamTransformer: streamTransfomer).listen { value in
            print("transform stream: \(value)")
        }.catchError { value in
            print("transform error: \(value)")
        }
        
        streamControllerPassword.stream.listen { normalValue in
            print("normal stream: \(normalValue)")
        }
        
        streamControllerPassword.sink.add("d")
        streamControllerPassword.sink.add("valid pasword")
        
        streamControllerPassword.stream.close()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}

