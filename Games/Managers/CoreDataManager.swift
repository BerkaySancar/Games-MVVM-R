//
//  CoreDataManager.swift
//  Games
//
//  Created by Berkay Sancar on 7.03.2023.
//

import Foundation
import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private let persistentContainer = NSPersistentContainer(name: "Favorite")
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private init() {
        persistentContainer.loadPersistentStores { _, error in
            if let error {
                fatalError(error.localizedDescription)
            }
        }
    }
        
    // MARK: - Save
    func save() {
        try? self.context.save()
    }
    
    // MARK: - FetchData
    func getFavorites() -> [Favorite]? {
        return try? self.context.fetch(Favorite.fetchRequest())
    }

    // MARK: - SaveData
    func addFavorite(name: String, imageURL: String) {
        let favorite = Favorite(context: context)
        favorite.name = name
        favorite.imageURL = imageURL
        save()
    }
    // MARK: - DeleteData
    func deleteFavorite(index: Int) {
        if let favs = getFavorites() {
            context.delete(favs[index])
            save()
        }
    }
}
