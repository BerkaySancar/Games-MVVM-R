//
//  MainTabBarController.swift
//  AppcentGameList
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
                                imageName: "list.bullet.circle",
                                selectedImageName: "list.bullet.circle.fill"),
            createNavController(viewController: FavoritesViewController(),
                                title: "Favorites",
                                imageName: "star",
                                selectedImageName: "star.fill")], animated: true)
    }
}
