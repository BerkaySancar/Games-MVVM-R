//
//  Favorite+CoreDataClass.swift
//  Games
//
//  Created by Berkay Sancar on 7.03.2023.
//
//

import Foundation
import CoreData

@objc(Favorite)
public class Favorite: NSManagedObject, Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }

    @NSManaged public var name: String?
    @NSManaged public var imageURL: String?
}
