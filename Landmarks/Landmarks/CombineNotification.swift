//
//  CombineNotification.swift
//  Landmarks
//
//  Created by 徐超 on 2022/4/7.
//

import Foundation
import Combine
import UIKit

class  CombineNotify {
    
    var cancellable: Cancellable?
    
    func  sendNotify(){
        cancellable = NotificationCenter.default
            .publisher(for: UIDevice.orientationDidChangeNotification)
            .filter(){ _ in UIDevice.current.orientation == .portrait}
            .sink() {_ in print("Orientation changed to portrait.") }
    }
    
    
    // 需要注意的是，orientationDidChangeNotification 通知的 userInfo 字典中不包含新的屏幕方向，因此 filter(_:) 操作符直接查询了 UIDevice。
    
}


