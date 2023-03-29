//
//  MockGameAPI.swift
//  Games
//
//  Created by Berkay Sancar on 16.03.2023.
//

import Foundation
@testable import Games

final class MockGameAPI: GameAPIProtocol {
    
    var invokedGetGameList = 0
    func getGameList(page: Int, completion: @escaping (Result<[Games.Game], Error>) -> Void) {
        invokedGetGameList += 1
        completion(.success([]))
    }
    
    func getGameDetail(id: Int, completion: @escaping (Result<Games.GameDetailResponse, Error>) -> Void) {
        
    }
}
