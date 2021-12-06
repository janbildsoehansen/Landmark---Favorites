//
//  FavoriterCategoryRow.swift
//  Tidevandstabeller
//
//  Created by Jan Bildsøe Hansen on 04/09/2021.
//  Copyright © 2021 Jan Bildsøe Hansen. All rights reserved.
//

import SwiftUI
import UIKit
import CoreData

struct FavoriterCategoryRow: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    var landmark: Landmark
    var landmarkIndex: Int {
        modelData.landmarks.firstIndex(where: { $0.id == landmark.id })!
    }
    @EnvironmentObject var modelData: ModelData
    @State private var showFavoritesOnly = true
    private var filteredLandmarks: [Landmark] {
        modelData.landmarks.filter { landmark in
            (!showFavoritesOnly || landmark.isFavorite)
        }
    }
    var body: some View {
        VStack(alignment: .leading) {
            
            if let list = filteredLandmarks, !list.isEmpty { // Can also use list.count > 0
                Text("Favorites")
                    .foregroundColor(.primary)
                    .font(.headline)
                    .padding(.leading, 15)
                    .padding(.top, 5)
            } else {
            }
        ScrollView(.horizontal, showsIndicators: false, content:  {
            HStack(alignment: .top, spacing: 0)  {
                ForEach(filteredLandmarks) {  landmark in
                    NavigationLink( destination: LandmarkDetail(landmark: landmark)) {
                        
                        FavoriterCategoryItem(landmark: landmark)
                        
                    }
                }
            }
        })
            
        }
    }
}
struct FavoriterCategoryItem: View {
    var landmark: Landmark
    var landmarkIndex: Int {
        modelData.landmarks.firstIndex(where: { $0.id == landmark.id })!
    }
    @EnvironmentObject var modelData: ModelData

    var body: some View {
        VStack(alignment: .center) {
            landmark.image
                .renderingMode(.original)
                .resizable()
                .frame(width: 155, height: 155)
                .cornerRadius(5.0)
            Text(landmark.name)
                .foregroundColor(.primary)
                .font(.caption)
            
        }.frame(height: 185).padding(.leading, 15)
    }
}
struct FavoriterCategoryRow_Previews: PreviewProvider {
    static let modelData = ModelData()
    static var previews: some View {
        FavoriterCategoryRow(
            landmark: modelData.landmarks[0]
        ).environmentObject(ModelData()).environment(\.colorScheme, .dark)
        FavoriterCategoryRow(
            landmark: modelData.landmarks[1]
        ).environment(\.colorScheme, .light)
    }
}
