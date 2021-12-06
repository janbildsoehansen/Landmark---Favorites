//
//  Stars+CoreDataProperties.swift
//  Landmarks
//
//  Created by Jan Bildsøe Hansen on 06/12/2021.
//  Copyright © 2021 Apple. All rights reserved.
//
//

import Foundation
import CoreData


extension Stars {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Stars> {
        return NSFetchRequest<Stars>(entityName: "Stars")
    }

    @NSManaged public var id: Int64
    @NSManaged public var isFavorite: Bool

}

extension Stars : Identifiable {

}
