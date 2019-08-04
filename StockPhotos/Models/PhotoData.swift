//
//  Welcome.swift
//  StockPhotos
//
//  Created by ONUR KILIC on 3.08.2019.
//  Copyright © 2019 Onur Kilic. All rights reserved.
//

import Foundation

struct PhotoData: Codable {
    let page, perPage, totalCount: Int
    let searchID: String
    var data: [Datum]
    //let spellcheckInfo: SpellcheckInfo
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case perPage = "per_page"
        case totalCount = "total_count"
        case searchID = "search_id"
        case data = "data"
        //case spellcheckInfo = "spellcheck_info"
    }
}
