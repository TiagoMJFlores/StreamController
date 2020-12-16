//
//  Stream.swift
//  StreamControllerLib
//
//  Created by Tiago Flores on 16/12/2020.
//

import Foundation


final public class Stream<T> {
    
    private let type: StreamType
    
    required init(type: StreamType = .singleListener) {
        self.type = type
    }
    
    typealias CallbackType = ((T) -> Void)?
    var listernerList: [CallbackType] = []
    
    public func listen(received callback: @escaping (T) -> Void) {
        
        switch type {
        
        case .singleListener:
            listernerList = [callback]
            break
        case .multipleListener:
            listernerList.append(callback)
            break
            
        }
   
    }
}
