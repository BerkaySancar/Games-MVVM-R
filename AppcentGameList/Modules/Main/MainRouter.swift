//
//  MainRouter.swift
//  AppcentGameList
//
//  Created by Berkay Sancar on 6.03.2023.
//

import Foundation

protocol MainRouterProtocol {
    func toDetail()
}

final class MainRouter {
    
    private weak var view: MainViewController?
    
    init(view: MainViewController) {
        self.view = view
    }
}

extension MainRouter: MainRouterProtocol {
    func toDetail() {
        
    }
}
