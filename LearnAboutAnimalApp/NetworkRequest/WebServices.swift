//
//  NetworkRequest.swift
//  ModbusApp
//
//  Created by skj on 5.10.2020.
//  Copyright © 2020 skj. All rights reserved.
//

import Foundation

class WebServices {    
    static func signup(payload: [String: String], completion: @escaping (Result<Signup, NetworkError>) -> ()) {
        let router = Router.signup(payload: payload)
        NetworkRequest.request(router) { (result: Result<Signup, NetworkError>) in
            completion(result)
        }
    }
    
    static func login(credential: [String: String], completion: @escaping (Result<Login, NetworkError>) -> ()) {
        let router = Router.login(credential: credential)
        NetworkRequest.request(router) { (result: Result<Login, NetworkError>) in
            completion(result)
        }
    }

}
