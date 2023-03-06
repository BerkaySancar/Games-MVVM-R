//
//  DetailBuilder.swift
//  AppcentGameList
//
//  Created by Berkay Sancar on 6.03.2023.
//

import Foundation

final class DetailBuilder {
    
    static func start(gameID: Int) -> DetailViewController {
        let view = DetailViewController()
        let viewModel = DetailViewModel(delegate: view, gameAPI: GameAPI.shared, gameID: gameID)
        view.viewModel = viewModel
        return view
    }
}
