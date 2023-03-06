//
//  Game.swift
//  AppcentGameList
//
//  Created by Berkay Sancar on 6.03.2023.
//

import Foundation

struct GameListResponse: Codable {
    let results: [Game]
}

struct Game: Codable {
    let id: Int
    let name: String
    let metacritic: Int?
    let backgroundImage: String?
    let released: String?
    
    private enum CodingKeys: String, CodingKey {
        case id, name, metacritic, released
        case backgroundImage = "background_image"
    }
}
