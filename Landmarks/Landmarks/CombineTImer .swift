//
//  CombineTImer .swift
//  Landmarks
//
//  Created by 徐超 on 2022/4/7.
//

import Foundation
import Combine

class  TimerPublisher {
    
    var cancellable: Cancellable?
    
    var myDispatchQueue = DispatchQueue.global()
    func timerTest() {
        
//        cancellable = Timer.publish(every: 1, tolerance: nil, on: .main, in: .default, options: nil)
//            .autoconnect()
//            .receive(on: myDispatchQueue, options: nil)
//            .assign(to: \.lastUpdated, on: myDataModel)
        
        
    }
    
    //  在这个例子中，Combine 操作符替换了上一个示例的闭包中的所有行为：
    //  receive(on:options:) 操作符确保了后续操作在指定的调度队列中执行，它替代了前面用到的 async() 调用；
    //  assign(to:on:)操作符通过键路径来更新数据模型的lastUpdated 属性；
    
    // 使用Combine来来简化你的代码时，你会发现 Timer.TimerPublisher 会产生新的 Date 实例作为其输出类型。而第一个示例的闭包是将 Timer 本身作为其参数，因此它必须手动创建新的 Date 实例。

//    代码易读性明显提升；
//    线程切换变得更简单；
//    数据模型的更新可以通过键路径(key path)来简化；
  
}


