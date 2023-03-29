//
//  MainTabBarController.swift
//  Games
//
//  Created by Berkay Sancar on 7.03.2023.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setControllers()
    }
    
    private func setControllers() {
        setViewControllers([
            createNavController(viewController: MainBuilder.start(),
                                title: "Games",
                                imageName: "gamecontroller",
                                selectedImageName: "gamecontroller.fill"),
            createNavController(viewController: FavoritesBuilder.start(),
                                title: "Favorites",
                                imageName: "star",
                                selectedImageName: "star.fill")], animated: true)
    }
}
