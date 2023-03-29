//
//  FavoritesViewModel.swift
//  Games
//
//  Created by Berkay Sancar on 7.03.2023.
//

import Foundation

protocol FavoritesViewModelOutputs: AnyObject {
    func prepareTableView()
    func dataRefreshed()
}

protocol FavoritesViewModelInputs {
    func viewDidLoad()
    func viewWillAppear()
    func numberOfRowsInSection() -> Int
    func cellForRowAt(index: IndexPath) -> Favorite?
    func deleteFavorite(index: IndexPath)
}

final class FavoritesViewModel {
    private weak var delegate: FavoritesViewModelOutputs?
    private let coreDataManager: CoreDataManager
    
    init(delegate: FavoritesViewModelOutputs, coreDataManager: CoreDataManager) {
        self.delegate = delegate
        self.coreDataManager = coreDataManager
    }
}

// MARK: - ViewModel Inputs
extension FavoritesViewModel: FavoritesViewModelInputs {
    
    func viewDidLoad() {
        delegate?.prepareTableView()
    }
    
    func viewWillAppear() {
        delegate?.dataRefreshed()
    }
    
    func numberOfRowsInSection() -> Int {
        return coreDataManager.getFavorites()?.count ?? 0
    }
    
    func cellForRowAt(index: IndexPath) -> Favorite? {
        if let fav = coreDataManager.getFavorites()?[index.row] {
            return fav
        }
        return nil
    }
    
    func deleteFavorite(index: IndexPath) {
        coreDataManager.deleteFavorite(index: index.row)
        delegate?.dataRefreshed()
    }
}
