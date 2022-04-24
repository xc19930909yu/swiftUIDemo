//
//  LandmarkList.swift
//  Landmarks
//
//  Created by 徐超 on 2022/3/31.
//

import SwiftUI

struct LandmarkList: View {
    @EnvironmentObject private var userData: UserData
    
    var body: some View {
        NavigationView {
            List{
                Toggle(isOn: $userData.showFavoritesOnly){
                   Text("Favorites only")
                }
                ForEach(userData.landmarks) { landmark in
                    if !self.userData.showFavoritesOnly || landmark.isFavorite {
                        NavigationLink(
                            destination: LandmarkDetail(landmark: landmark)
                                        .environmentObject(self.userData)
                        ){
                            LandmarkRow(landmark: landmark)
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Landmarks"))
        }
    }
}


struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkList()
            .environmentObject(UserData())
    }
    //        LandmarkList()
    //            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
  
//        ForEach(["iPhone 8","iPhone 12 Pro","iPhone 12 Pro Max"], id: \.self){ deviceName in
//            LandmarkList()
//                .previewDevice(PreviewDevice(rawValue: deviceName))
//                .previewDisplayName(deviceName)
//        }
   
}
