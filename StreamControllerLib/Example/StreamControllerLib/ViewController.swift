//
//  ViewController.swift
//  StreamControllerLib
//
//  Created by tiagoflores2@outlook.com on 12/16/2020.
//  Copyright (c) 2020 tiagoflores2@outlook.com. All rights reserved.
//

import UIKit
import StreamControllerLib

class ViewController: UIViewController {

    var streamControllerNumber = StreamController<Int>(streamListenType: .multipleListener)
    var streamControllerPassword = StreamController<String>(streamListenType: .multipleListener)

    var persistentStreamController = PersistentStreamController<String>()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        print("init test")
        
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
                

        persistentStreamController.sink.add("PersistentStream first value sent")
        persistentStreamController.sink.add("PersistentStream last value sent. Always stored and waiting to be used")
        
        persistentStreamController.stream.listen { value in
            print("I am too late for listen values already sent")
        }
       
        if let storedValue = persistentStreamController.value {
            print(storedValue)
        }
        */
        
        let streamTransfomer = StreamTransformer<String, Any>.fromHandlers(
            handlers: { (data: String, sink: EventSink<Any>) in
                
                if (data.count > 5) {
                    sink.add(true)
                } else {
                    sink.addError("password too short")
                }
               
            })
        
        let  validatePasswordStream = streamControllerPassword.stream.transform(streamTransformer: streamTransfomer).listen { value in
            print("transform stream: \(value)")
        }.catchError { value in
            print("transform error: \(value)")
        }
        
        streamControllerPassword.stream.listen { normalValue in
            print("normal stream: \(normalValue)")
        }
        
        streamControllerPassword.sink.add("d")
        streamControllerPassword.sink.add("valid pasword")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}

