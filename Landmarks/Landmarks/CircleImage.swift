//
//  CircleImage.swift
//  Landmarks
//
//  Created by 徐超 on 2022/3/31.
//

import SwiftUI

struct CircleImage: View {
    
    //存储属性
    var image:Image
    var body: some View {
            image
            .clipShape(Circle())
            .overlay(
                Circle().stroke(Color.white, lineWidth:
                        4))
            .shadow(radius: 10)
            
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image:Image("turtlerock"))
    }
}
