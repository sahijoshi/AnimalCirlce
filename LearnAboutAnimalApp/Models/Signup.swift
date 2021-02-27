//
//  BaseClass.swift
//
//  Created by skj on 3.1.2021
//  Copyright (c) . All rights reserved.
//

import Foundation

class Signup: Codable {

    enum CodingKeys: String, CodingKey {
      case message
      case status
    }

    var message: String?
    var status: Bool?

    init (message: String?, status: Bool?) {
      self.message = message
      self.status = status
    }

    required init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      message = try container.decodeIfPresent(String.self, forKey: .message)
      status = try container.decodeIfPresent(Bool.self, forKey: .status)
    }
}
