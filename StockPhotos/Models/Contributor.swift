//
//  Contributor.swift
//  StockPhotos
//
//  Created by ONUR KILIC on 3.08.2019.
//  Copyright © 2019 Onur Kilic. All rights reserved.
//

import Foundation

struct Contributor: Codable {
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
    }
}
