//
//  ConnectablePublisher.swift
//  Landmarks
//
//  Created by 徐超 on 2022/4/7.
//

import Foundation
import Combine

// makeConnectable()操作符
class  ConnectablePublisherDemo {
    
    private var cancellabel1: AnyCancellable?
    private var cancellabel2: AnyCancellable?
    private var cancellabel3: AnyCancellable?
    private var connection:Cancellable?
    
    func run(){
        //上面的代码示例中使用了autoconnect(), 订阅者可以马上接收到定时器发送的元素。 如果没有autoconnect(), 我们需要在某个时刻手动地调用connect()方法
        cancellabel3 = Timer.publish(every: 1, on: .main, in: .default)
            .autoconnect()
            .sink { date in
                print("Date now:\(date)")
        }
        
        let url = URL(string: "http://www.drvoice.cn/speaker/151120?webview=1")!
        let connectable = URLSession.shared
            .dataTaskPublisher(for: url)
            .map(\.data)
            .catch() { _ in  Just(Data()) }
            .share()
            .makeConnectable()  //阻止发布者发布内容
        
        cancellabel1 = connectable
            .sink(receiveCompletion: { print("Received completion 1: \($0). ")}, receiveValue: {  print("Received data 1: \($0.count) bytes.")})
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.cancellabel2 = connectable.sink(receiveCompletion: { print("Received completion 2: \($0).") }, receiveValue: { print("Received data 2: \($0.count) bytes. ")})
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // 显式地启动发布。返回值需要被强引用，可用于取消发布（主动调用cancel方法或返回值被析构）
            self.connection = connectable.connect()
        }
        
        // 在 makeConnectable() 操作符前面有一个 share() 操作符！请问，这个操作符有什么作用
        
    }
    
}

