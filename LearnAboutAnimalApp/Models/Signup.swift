//
//  BaseClass.swift
//
//  Created by skj on 3.1.2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Signup: Codable {

  enum CodingKeys: String, CodingKey {
    case status
  }

  var status: Bool?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    status = try container.decodeIfPresent(Bool.self, forKey: .status)
  }

}
