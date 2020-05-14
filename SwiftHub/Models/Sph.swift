//
//  Sph.swift
//  SwiftHub
//
//  Created by shengnan liu on 13/5/20.
//  Copyright © 2020 Khoren Markosyan. All rights reserved.
//

import Foundation
import ObjectMapper


struct SphResult: Mappable {
    var resourceId: String?
    var records: [Record]?

    init?(map: Map) {}
    init() {}

    mutating func mapping(map: Map) {
        resourceId <- map["resource_id"]
        records <- map["records"]
    }
}

struct Sph: Mappable {
    
    var success: Bool?
    var help: String?
    var result: SphResult?

    init?(map: Map) {}
    init() {}

    mutating func mapping(map: Map) {
        success <- map["success"]
        help <- map["help"]
        result <- map["result"]
    }
}
