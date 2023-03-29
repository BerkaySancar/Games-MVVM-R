//
//  GameDetailResponse.swift
//  Games
//
//  Created by Berkay Sancar on 6.03.2023.
//

import Foundation

struct GameDetailResponse: Codable {
    let name: String
    let description: String?
    let backgroundImage: String?
    
    private enum CodingKeys: String, CodingKey {
        case name, description
        case backgroundImage = "background_image"
    }
}
