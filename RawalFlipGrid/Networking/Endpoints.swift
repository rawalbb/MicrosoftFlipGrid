//
//  Endpoints.swift
//  RawalFlipGrid
//
//  Created by Nirali Rawal on 10/23/21.
//

import Foundation

enum Endpoints{
    case sendRegistrationRequest
    
    var host: String{
        switch self{
        case .sendRegistrationRequest:
            return ""
        }
    }
    
    var scheme: String{
        switch self{
        case .sendRegistrationRequest:
            return ""
        }
    }
    
    var path: String{
        switch self{
        case .sendRegistrationRequest:
            return ""
        }
    }
    
    var httpMethod: String{
        switch self{
        case .sendRegistrationRequest:
            return "POST"
        }
    }
    
    var queryItems: [URLQueryItem]?{
        switch self{
        case .sendRegistrationRequest:
            return nil
        }
    }
    
    var url: URL?{
        var components = URLComponents()
        components.host = host
        components.path = path
        components.scheme = scheme
        components.queryItems = queryItems
        return components.url
    }
}
