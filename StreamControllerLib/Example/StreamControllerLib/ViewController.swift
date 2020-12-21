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

    var streamController = StreamController<Int>(streamListenType: .multipleListener)
    
    var persistentStreamController = PersistentStreamController<String>()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        print("init test")
        
        streamController.stream.listen { value in
            print("received 1: \(value)")
        }
        
        streamController.stream.listen { value in
            print("received 2: \(value)")
        }.catchError { value in
            print("throw error: \(value)")
        }
    
        streamController.sink.add(2)
        streamController.sink.addError("send error")
        
        streamController.sink.close()
        streamController.stream.listen { value in
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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}

