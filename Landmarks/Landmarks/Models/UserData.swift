//
//  UserData.swift
//  Landmarks
//
//  Created by 徐超 on 2022/3/31.
//

import SwiftUI
import  Combine

final class  UserData: ObservableObject {
    @Published var showFavoritesOnly = false
    @Published var landmarks = landmarkData
}


