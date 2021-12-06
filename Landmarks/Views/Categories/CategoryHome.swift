/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view showing featured landmarks above a list of landmarks grouped by category.
*/

import SwiftUI
import CoreData
struct CategoryHome: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var modelData: ModelData
    @State private var showingProfile = false
    @FetchRequest(
          entity: Stars.entity(),
          sortDescriptors: [
              NSSortDescriptor(keyPath: \Stars.isFavorite, ascending: false)
          ]
      )
    
    var landmarks: FetchedResults<Stars>
    @State private var isOnlyFavorite: Bool = true
    @State private var showFavoritesOnly = true
    var body: some View {
        NavigationView {
            List {
                PageView(pages: modelData.features.map { FeatureCard(landmark: $0) })
                    .aspectRatio(3 / 2, contentMode: .fit)
                    .listRowInsets(EdgeInsets())
                
                FavoriterCategoryRow(landmark: modelData.landmarks[0])
                .listRowInsets(EdgeInsets())
                
                ForEach(modelData.categories.keys.sorted(), id: \.self) { key in
                    CategoryRow(categoryName: key, items: modelData.categories[key]!)
                }
                .listRowInsets(EdgeInsets())
            }
            .listStyle(.inset)
            .navigationTitle("Featured")
            .toolbar {
                Button {
                    showingProfile.toggle()
                } label: {
                    Label("User Profile", systemImage: "person.crop.circle")
                }
            }
            .sheet(isPresented: $showingProfile) {
                ProfileHost()
                    .environmentObject(modelData)
            }
        }
    }
}

struct CategoryHome_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHome()
            .environmentObject(ModelData())
    }
}
