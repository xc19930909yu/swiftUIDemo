//
//  CombineAsyn.swift
//  Landmarks
//
//  Created by 徐超 on 2022/4/7.
//

import Foundation
import Combine

//前言
//用 Future 取代回调闭包
//用输出类型(Output Types)代表 Future 的参数
//用 Subject 取代重复执行的闭包
//总结

//完成处理器(Completion handlers)。它其实是调用方提供的一个闭包，当一个耗时任务完成后，这个闭包会被调用一次；
//闭包属性(Closure properties)。它其实也是调用方提供的一个闭包，这个闭包会在每一次异步事件发生时被调用；

// Combine为这些模式提供了强大的替换选项。 它可以让你消除这种样板代码，并且充分利用Combine 中的操作符。当你在应用的其他地方采用 Combine 时，将异步调用点转换为 Combine 可以提高代码的一致性和可读性。

class  CombineAsyncDemo {
    
    private lazy var myDoSomethingSubject = PassthroughSubject<Void, Never>()
    lazy var doSomethingSubject = myDoSomethingSubject.eraseToAnyPublisher()
    
    private var cancellabel: AnyCancellable?
    
    func performAsyncActionAsFuture() ->  Future <Void, Never> {
        return  Future(){  promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                promise(Result.success(()))
            }
        }
    }
    
    func  testAsync(){
        //调用方法
        cancellabel = performAsyncActionAsFuture()
            .sink{ _ in
                print("Future Succeeded.")
            }
    }
    
    
    // 使用输出类型表示未来的参数
    func  performAsyncActionAsFutureWithParameter() -> Future <Int, Never> {
          
        return  Future(){ promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                let rn = Int.random(in: 1...10)
                promise(Result.success(rn))
            }
        }
    }
    
    //这种基于 Combine 的方法还有一个优势，subject 可以调用 send(completion:) 来告知订阅者：不会再有后续的事件发生，或者发生了一个错误。
    //用 Subject 取代重复执行的闭包
    func performDoSomething() {
        // 发布一个空元组元素
        myDoSomethingSubject.send(())
    }
    
    
}
