/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Storage for model data.
*/

import Foundation
import Combine

final class ModelData: ObservableObject {
    @Published var landmarks: [Landmark] = load("landmarkData.json")
    var hikes: [Hike] = load("hikeData.json")
    @Published var profile = Profile.default
    @Published var showFavoritesOnly = false
    @Published var isFavorite = [Landmark]()
    init() {
           takeUrl()
       }
    func takeUrl() {
        let url = Bundle.main.url(forResource: "landmarkData", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        landmarks = try! JSONDecoder().decode([Landmark].self, from: data)
        let decodedData = try! JSONDecoder().decode([Landmark].self, from: data)
        DispatchQueue.main.async {
            self.landmarks = decodedData
            for i in 0..<self.landmarks.count {
//                            dump (self.landmarks[i].name)
//                             dump (UserDefaults.standard.string (forKey:  self.landmarks[i].name))
                
                if UserDefaults.standard.string (forKey:  self.landmarks[i].name) != nil {
                    
                    self.landmarks[i].isFavorite =  Bool (UserDefaults.standard.string (forKey: self.landmarks[i].name) ?? "false")!
                }}
       
        }
    }
    var features: [Landmark] {
        landmarks.filter { $0.isFeatured }
    }

    var categories: [String: [Landmark]] {
        Dictionary(
            grouping: landmarks,
            by: { $0.category.rawValue }
        )
    }
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
func saveJSON<T: Codable>(data: T, filename: String) {
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    
    let jsonData: Data
    do {
        jsonData = try encoder.encode(data)
    }
    catch {
        return
    }
    
    guard let jsonString = String(data: jsonData, encoding: .utf8) else {
        print("error creating JSON string from data")
        return
    }
        
    if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let fileURL = dir.appendingPathComponent(filename)
        
//        print("dir:     \(dir)")
        print("fileURL: \(fileURL)")
        
        do{
            try jsonString.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
        }
        catch {
            return
        }
    }
    else { print("error getting Document Directory") }
}
