//
//  Record.swift
//  SwiftHub
//
//  Created by shengnan liu on 13/5/20.
//  Copyright © 2020 Khoren Markosyan. All rights reserved.
//

import Foundation
import ObjectMapper

struct Record: Mappable {
    
    var id: Int?
    var quarter: String?
    var volumeOfMobileData: String?

    init?(map: Map) {}
    init() {}

    mutating func mapping(map: Map) {
        id <- map["_id"]
        quarter <- map["quarter"]
        volumeOfMobileData <- map["volume_of_mobile_data"]
    }
}
