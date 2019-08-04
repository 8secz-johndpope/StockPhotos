//
//  Datum.swift
//  StockPhotos
//
//  Created by ONUR KILIC on 3.08.2019.
//  Copyright © 2019 Onur Kilic. All rights reserved.
//

import Foundation

struct Datum: Codable {
    let id: String
    let aspect: Double
    let assets: Assets
    let contributor: Contributor
    let datumDescription, imageType: String
    let hasModelRelease: Bool
    let mediaType: String
    
    enum CodingKeys: String, CodingKey {
        case id, aspect, assets, contributor
        case datumDescription = "description"
        case imageType = "image_type"
        case hasModelRelease = "has_model_release"
        case mediaType = "media_type"
    }
}
