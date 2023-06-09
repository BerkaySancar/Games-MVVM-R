//
//  MainRouter.swift
//  Games
//
//  Created by Berkay Sancar on 6.03.2023.
//

import Foundation

protocol MainRouterProtocol {
    func toDetail(id: Int)
}

final class MainRouter {
    
    private weak var view: MainViewController?
    
    init(view: MainViewController) {
        self.view = view
    }
}

extension MainRouter: MainRouterProtocol {
    func toDetail(id: Int) {
        self.view?.navigationController?.pushViewController(DetailBuilder.start(gameID: id), animated: true)
    }
}
