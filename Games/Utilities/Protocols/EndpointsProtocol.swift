//
//  EndpointsProtocol.swift
//  Games
//
//  Created by Berkay Sancar on 6.03.2023.
//

import Alamofire
import Foundation

protocol EndpointsProtocol {
    var baseURLString: String { get }
    var apiKey: String { get }
    var parameters: Parameters? { get }
    var headers: HTTPHeaders? { get }
}

extension EndpointsProtocol {
    var url: String {
        return baseURLString + apiKey
    }
}
