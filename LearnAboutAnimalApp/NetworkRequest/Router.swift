//
//  Router.swift
//  ModbusApp
//
//  Created by skj on 5.10.2020.
//  Copyright © 2020 skj. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
}

protocol EndPointType {
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
}

protocol URLConverter {
    func asURLRequest() throws -> URLRequest
}

enum Router: EndPointType, URLConverter {
    case signup(payload: [String: String])
    case login(credential: [String: String])

    var baseURL: String {
        return Constants.URL.baseUrl
    }
    
    var method: HTTPMethod {
        switch self {
            case .signup, .login: return .post
        }
    }
    
    var path: String {
        switch self {
        case .signup:
            return "/signup"
        case .login:
            return "/login"
        }
    }
    
    var parameters: [String: String] {
        switch self {
        case .signup (let payload):
            return payload
        case .login (let credential):
            return credential
        }
    }
    
    func asURLRequest() -> URLRequest {
        let baseUrl = URL(string: baseURL)
        let url = URL(string: (baseUrl?.appendingPathComponent(path).absoluteString.removingPercentEncoding)!)
        var urlRequest = URLRequest(url: url!, timeoutInterval: TimeInterval(10 * 1000))
        urlRequest.httpMethod = method.rawValue
        
        if !parameters.isEmpty {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            do {
                let jsonBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                urlRequest.httpBody = jsonBody
            } catch {
                
            }
        }
        NetworkLogger.log(request: urlRequest)
        return urlRequest
    }
    
}
