//
//  MainBuilder.swift
//  AppcentGameList
//
//  Created by Berkay Sancar on 6.03.2023.
//

import Foundation

final class MainBuilder {
    
    static func start() -> MainViewController {
        let mainVC = MainViewController()
        let router = MainRouter(view: mainVC)
        let viewModel = MainViewModel(delegate: mainVC, router: router, gameAPI: GameAPI.shared)
        mainVC.viewModel = viewModel
        return mainVC
    }
}
