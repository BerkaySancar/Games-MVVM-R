//
//  GameEndpoints.swift
//  AppcentGameList
//
//  Created by Berkay Sancar on 6.03.2023.
//

import Alamofire
import Foundation

enum GameEndpoints {
    case list(page: Int)
    case detail(id: Int)
}

extension GameEndpoints: EndpointsProtocol {
 
    var baseURLString: String {
        switch self {
        case .list(let page):
            return "https://api.rawg.io/api/games?page=\(page)"
        case .detail(let id):
            return "https://api.rawg.io/api/games/\(id)?"
        }
    }
   
    var apiKey: String {
        switch self {
        case .list:
            return "&key=7a692c0b214f47b0bb664039491b1fcf"
        case .detail:
            return "&key=7a692c0b214f47b0bb664039491b1fcf"
        }
    }
 
    var parameters: Parameters? {
        switch self {
        case .list:
            return nil
        case .detail:
            return nil
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .list:
            return ["Content-Type": "application/json"]
        case .detail:
            return ["Content-Type": "application/json"]
        }
    }
}
