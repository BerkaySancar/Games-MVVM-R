//
//  FavoritesBuilder.swift
//  Games
//
//  Created by Berkay Sancar on 7.03.2023.
//

import Foundation

final class FavoritesBuilder {
    
    static func start() -> FavoritesViewController {
        let view = FavoritesViewController()
        let viewModel = FavoritesViewModel(delegate: view, coreDataManager: CoreDataManager.shared)
        view.viewModel = viewModel
        return view
    }
}
