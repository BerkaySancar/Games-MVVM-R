//
//  MockMainRouter.swift
//  Games
//
//  Created by Berkay Sancar on 16.03.2023.
//

import Foundation
@testable import AppcentGameList

final class MockMainRouter: MainRouterProtocol {
    
    var invokedToDetailCount = 0
    var invokedID: Int? = nil
    func toDetail(id: Int) {
        invokedToDetailCount = 1
        invokedID = id
    }
}
