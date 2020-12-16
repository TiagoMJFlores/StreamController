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

    var object = StreamController<Int>.broadcast()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        object.stream.listen { value in
            print("1: \(value)")
        }
        
        object.stream.listen { value in
            print("2: \(value)")
        }
    
        object.sink.add(event: 2)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}

