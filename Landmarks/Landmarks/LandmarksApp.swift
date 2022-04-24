//
//  LandmarksApp.swift
//  Landmarks
//
//  Created by 徐超 on 2022/3/31.
//

import SwiftUI
import Combine

@main
struct LandmarksApp: App {
    
    private var  cancellabel: AnyCancellable?
    
    private var cancellabel1: AnyCancellable?
    
    private var cancellable2: AnyCancellable?
    
    var body: some Scene {
        WindowGroup {
            //LandmarkDetail()
//            LandmarkList()
//                .environmentObject(UserData())
        }
    }
    
    init() {
        //ConnectablePublisherDemo().run()
        
        // 订阅  timerPub
//        let mySub = MySubscriber()
//        print("Subscribing at \(Date())")
//        timerPub.subscribe(mySub)
        
        // Async异步调用的实现
        //将返回设置为全局变量进行打印
        cancellabel = CombineAsyncDemo().performAsyncActionAsFutureWithParameter()
            .sink { rn in
                print("Got random number \(rn) .")
         }
        
        cancellabel1 = CombineAsyncDemo().performAsyncActionAsFuture()
            .sink(receiveValue: { _ in
                print("Future Succeeded.")
            })
        
        let combineDemo = CombineAsyncDemo()
        //这个在类里面是全局变量持有可以用局部变量接收（或者全局变量）
        cancellable2 = combineDemo.doSomethingSubject
            .sink { _ in
                print("Did something with Combine.")
            }
        
        combineDemo.performDoSomething()
        
        
        let combineSubject = SubjectsDemo()
        
        

        
    }
    
}
