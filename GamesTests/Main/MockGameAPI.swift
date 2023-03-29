//
//  MockGameAPI.swift
//  Games
//
//  Created by Berkay Sancar on 16.03.2023.
//

import Foundation
@testable import AppcentGameList

final class MockGameAPI: GameAPIProtocol {
    
    var invokedGetGameList = 0
    func getGameList(page: Int, completion: @escaping (Result<[AppcentGameList.Game], Error>) -> Void) {
        invokedGetGameList += 1
        completion(.success([]))
    }
    
    func getGameDetail(id: Int, completion: @escaping (Result<AppcentGameList.GameDetailResponse, Error>) -> Void) {
        
    }
}
