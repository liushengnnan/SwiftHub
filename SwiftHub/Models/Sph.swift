//
//  Sph.swift
//  SwiftHub
//
//  Created by shengnan liu on 13/5/20.
//  Copyright © 2020 Khoren Markosyan. All rights reserved.
//

import Foundation
import ObjectMapper

struct YearRecord {
    var decrease: Bool = false
    var year: String?
    var volumeOfMobileData: String?
    var quarters: [Record]?
    init() {}
    init(records: [Record], year: String?) {
        self.quarters = records
        self.year = year
        var sum: NSDecimalNumber = 0
        var increase = true
        var pre: NSDecimalNumber = 0
        for record in records {
            let val = record.volume
            increase = increase && pre.compare(val) == .orderedAscending
            pre = val
            sum = sum.adding(val)
        }
        self.volumeOfMobileData = sum.description
        self.decrease = !increase
    }

    static func convertToYearRecords(records: [Record]) -> [YearRecord] {
        var tmpRecords: [Record] = []
        var yearRecords: [YearRecord] = []
        var tmpYear = ""
        for record in records {
            let year = String(record.quarter?.prefix(4) ?? "")
            if year != tmpYear {
                if !tmpRecords.isEmpty {
                    let tmp = YearRecord(records: tmpRecords, year: tmpYear)
                    yearRecords.append(tmp)
                }
            } else {
                tmpRecords.append(record)
            }
            tmpYear = year
        }
        let last = YearRecord(records: tmpRecords, year: tmpYear)
        yearRecords.append(last)
        return yearRecords
    }
}

struct Record: Mappable {
    var id: Int?
    var quarter: String?
    var volumeOfMobileData: String?
    var volume: NSDecimalNumber {
        return NSDecimalNumber(string: volumeOfMobileData)
    }
    init?(map: Map) {}
    init() {}

    mutating func mapping(map: Map) {
        id <- map["_id"]
        quarter <- map["quarter"]
        volumeOfMobileData <- map["volume_of_mobile_data"]
    }
}

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
