//
//  CombineKVO.swift
//  Landmarks
//
//  Created by 徐超 on 2022/4/7.
//

import Foundation
import Combine

class UserInfo: NSObject {
    @objc dynamic var lastLogin: Date  = Date(timeIntervalSince1970: 0)
}


// 实际应用在viewDidLoad中
class CombineKVODemo{
    @objc var userInfo = UserInfo()
    var cancellabel: Cancellable?
    
    func combineKvo(){
         cancellabel = userInfo.publisher(for: \.lastLogin)
            .sink(receiveValue: { date in
                print("lastLogin now \(date).")
            })
    }
    
    func changeValue(){
        userInfo.lastLogin = Date()
    }
    
    // KVO发布者 会生成观察类型的元素（在本例中为 Date），而不是 NSKeyValueObservedChange。这样就节省了一步操作，因为你不必像前一个示例中那样从 change 对象中获取 newValue。
    
    //如果上面的示例变得更加复杂，传统的 KVO 代码可能会变得非常臃肿，而基于 Combine 的 KVO 代码可以利用各种操作符进行链式调用。这样，就可以让代码更优雅，同时保持代码的易读性。对于以后维护这段代码的人来说，这将是一种辛福的感觉~ 😉
    
    
}
