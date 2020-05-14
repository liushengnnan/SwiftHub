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
        var sum: Float = 0
        var increase = true
        var pre: Float = -1
        for record in records {
            let val = Float(record.volumeOfMobileData!) ?? 0
            increase = increase && (val > pre)
            pre = val
            sum += val
        }
        self.volumeOfMobileData = String(sum)
        self.decrease = !increase
    }
    
    static func convertToYearRecords(records: [Record]) -> [YearRecord] {
        var dic: [String: [Record]] = [:]
        for record in records {
            let year = String(record.quarter?.prefix(4) ?? "")
            if var tmp = dic[year] {
                tmp.append(record)
            } else {
                dic[year] = [record]
            }
        }
        var yearRecords : [YearRecord] = []
        for (year, quarters) in dic {
            let yearRecord = YearRecord(records: quarters, year: year)
            yearRecords.append(yearRecord)
        }
        return yearRecords
    }
    
    static func convertToYearRecords2(records: [Record]) -> [YearRecord] {
        var tmpRecords: [Record] = []
        var yearRecords : [YearRecord] = []
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
