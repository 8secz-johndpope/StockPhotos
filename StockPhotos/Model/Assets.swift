//
//  Assets.swift
//  StockPhotos
//
//  Created by ONUR KILIC on 3.08.2019.
//  Copyright © 2019 Onur Kilic. All rights reserved.
//

import Foundation

struct Assets: Codable {
    let preview, smallThumb, largeThumb, hugeThumb: Thumb
    let preview1000, preview1500: Thumb
    
    enum CodingKeys: String, CodingKey {
        case preview = "preview"
        case smallThumb = "small_thumb"
        case largeThumb = "large_thumb"
        case hugeThumb = "huge_thumb"
        case preview1000 = "preview_1000"
        case preview1500 = "preview_1500"
    }
}
