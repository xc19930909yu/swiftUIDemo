//
//  CombineSubscriber.swift
//  Landmarks
//
//  Created by 徐超 on 2022/4/7.
//

import Foundation
import Combine

//前言
//在发布者生产元素时消耗它们
//使用自定义的订阅者施加背压(back pressure)
//使用背压操作符管理无限需求(Unlimited Demand)
//总结


// 发布者: 使用一个定时器来每秒发送一个日期对象
let  timerPub = Timer.publish(every: 1, tolerance: nil, on: .main, in: .default, options: nil)
    .autoconnect()

// 订阅者: 在订阅以后，等待5秒，然后请求最多3个值
class  MySubscriber: Subscriber {
    typealias  Input = Date
    typealias  Failure = Never
    var  subscription:Subscription?
    
    func receive(subscription: Subscription) {
        print("published  received")
        self.subscription = subscription
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            subscription.request(.max(3))
        }
    }
    
    func receive(_ input: Date) -> Subscribers.Demand {
        print("\(input)   \(Date())")
        return  Subscribers.Demand.none
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        print("--done--")
    }
    
}


// buffer(size:prefetch:whenFull:)，保留来自上游发布者的固定数量的项目。缓冲满了之后，缓冲区会丢弃元素或抛出错误；

// debounce(for:scheduler:options:)，只在上游发布者在指定的时间间隔内停止发布时才发布；

// throttle(for:scheduler:latest:)，以给定的最大速率生成元素。如果在一个间隔内接收到多个元素，则仅发送最新的或最早的元素;

// collect(_:) 和 collect(_:options:) 聚集元素，直到它们超过给定的数量或时间间隔，然后向订阅者发送元素数组。如果订阅者可以同时处理多个元素，这个操作符将是很好的选择。

//由于这些操作符可以控制订阅者接收的元素数量，因此可以放心地连接无限需求的订阅者，例如：sink(receiveValue:) 和 assign(to:on:)。
