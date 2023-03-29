//
//  UITabBar+Extension.swift
//  Games
//
//  Created by Berkay Sancar on 7.03.2023.
//

import Foundation
import UIKit.UITabBarController

extension UITabBarController {
    
    func createNavController(viewController: UIViewController, title: String, imageName: String, selectedImageName: String) -> UIViewController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(systemName: imageName)
        navController.tabBarItem.selectedImage = UIImage(systemName: selectedImageName)
        navController.navigationBar.prefersLargeTitles = false
        viewController.navigationItem.title = title
        viewController.view.backgroundColor = .systemBackground
        return navController
    }
}
