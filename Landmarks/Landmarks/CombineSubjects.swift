//
//  CombineSubjects.swift
//  Landmarks
//
//  Created by 徐超 on 2022/4/23.
//

import Foundation
import Combine

//前言
//PassthroughSubject
//CurrentValueSubject
//Subject 作为订阅者
//常见用法
//总结

//Subject 是一类比较特殊的发布者，因为它同时也是订阅者。Combine 提供了两类 Subject ：PassthroughSubject 和 CurrentValueSubject。

//PassthroughSubject

// PassthroughSubject 可以向下游订阅者广播发送元素。使用 PassthroughSubject 可以很好地适应命令式编程场景。

// 如果没有订阅者，或者需求为0，PassthroughSubject 就会丢弃元素。

final class  SubjectsDemo {
    
    private var cancellabel: AnyCancellable?
    private let passThroughtSubject = PassthroughSubject<Int, Never>()
    
    func passThroughtSubjectDemo() {
        cancellabel = passThroughtSubject
            .sink{
                print(#function, $0)
            }
        passThroughtSubject.send(1)
        passThroughtSubject.send(2)
        passThroughtSubject.send(3)
    }
}


// CurrentValueSubject

//CurrentValueSubject 包装一个值，当这个值发生改变时，它会发布一个新的元素给下游订阅者。
//
//CurrentValueSubject 需要在初始化时提供一个默认值，您可以通过 value 属性访问这个值。在调用 send(_:) 方法发送元素后，这个缓存值也会被更新。

final class SubjectsTwoDemo {
    
    private var cancellable: AnyCancellable?
    private let currentValueSubject = CurrentValueSubject<Int, Never>(1)
    
    func currentValueSubjectDemo() {
         cancellable = currentValueSubject
            .sink{   [unowned self]   in
                print(#function, $0)
                print("Value of currentValueSubject:", self.currentValueSubject.value)
            }
        currentValueSubject.send(2)
        currentValueSubject.send(3)
    }
}


//Subject 作为订阅者
final class SubjectThreeDemo {
    
    private var cancellable1: AnyCancellable?
    private var cancellabel2: AnyCancellable?
    
    private let optionalCurrentValueSubject = CurrentValueSubject<Int?, Never>(nil)
    
    private func subjectSubscriber() {
        cancellable1 =  optionalCurrentValueSubject
            .sink{
                print(#function, $0)
            }
        cancellabel2 = [1,2,3].publisher
            .subscribe(optionalCurrentValueSubject)
    }
    
}


//在使用 Subject 时，我们往往不会将其暴露给调用方。这时候，可以使用 eraseToAnyPublisher 操作符来隐藏内部的 Subject。

struct Model {
    let id: UUID
    let name: String
}



final class ViewModel {
    private let modelSubject = CurrentValueSubject<Model?,Never>(nil)
    var modelPublisher:AnyPublisher<Model?, Never> {
        return modelSubject.eraseToAnyPublisher()
    }
    
    func updateName(_ name: String) {
        modelSubject.send(.init(id: UUID(), name: name))
    }
}



