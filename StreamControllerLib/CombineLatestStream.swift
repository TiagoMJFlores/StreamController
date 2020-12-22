//
//  CombineLatestStream.swift
//  StreamControllerLib
//
//  Created by Tiago Flores on 22/12/2020.
//

import Foundation

public class CombineLatestStream<T> {
    
    private class CombineValues {
        var valueA: Any?
        var valueB: Any?
    }
    
    private let streamController: StreamController<T>
   
    
    public init() {
        streamController = StreamController<T>()
    }
    
    @discardableResult
    public func combine2<A, B>(streamA: Stream<A>, streamB: Stream<B>, combineCallback: @escaping ( (A, B) -> T)) -> Stream<T> {
        
        let combineValue = CombineValues()
      
        let checkIfReady = {
            self.checkCombineOperation2Status(combineValue: combineValue, streamA: streamA, streamB: streamB, combineCallback: combineCallback)
        }
        
        streamA.listen { value in
            combineValue.valueA = value
            checkIfReady()
        }
        streamB.listen { value in
            combineValue.valueB = value
            checkIfReady()
        }
   
        return streamController.stream
    }
    
    private func checkCombineOperation2Status<A, B>(combineValue: CombineValues, streamA: Stream<A>, streamB: Stream<B>, combineCallback: @escaping ( (A, B) -> T)) {
     
        guard let valueA = combineValue.valueA as? A,
              let valueB = combineValue.valueB as? B else {
            return
        }
        let result = combineCallback(valueA, valueB)
        self.streamController.sink.add(result)
        self.resetCombineValues(combineValue: combineValue)
    }
    
    
    private func resetCombineValues(combineValue: CombineValues) {
        combineValue.valueA = nil
        combineValue.valueB = nil
    }
    
}
