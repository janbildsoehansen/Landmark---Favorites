/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The top-level definition of the Landmarks app.
*/

import SwiftUI
import CoreData

@main
struct LandmarksApp: App {
    @StateObject private var modelData = ModelData()
    let context = Dao.sharedInstance.persistentContainer.viewContext
    @Environment(\.managedObjectContext) var managedObjectContext
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
                .environment(\.managedObjectContext, context)
            
        }
    }
}
