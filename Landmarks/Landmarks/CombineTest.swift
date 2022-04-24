//
//  Combine_Test.swift
//  Landmarks
//
//  Created by 徐超 on 2022/4/2.
//

import Foundation
import Combine

class  CommonOperationDemo {
    
    private  var cancellabels = Set<AnyCancellable>()
    
    func printDemo() {
        [1,2].publisher
            .print("_")
            .sink { _ in }
            .store(in: &cancellabels)
    }
    
    func testConnectable() {
        ConnectablePublisherDemo().run()
        
    }
    
    
}



