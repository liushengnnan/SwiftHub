//
//  SphTests.swift
//  SwiftHubTests
//
//  Created by shengnan liu on 14/5/20.
//  Copyright © 2020 Khoren Markosyan. All rights reserved.
//

import Quick
import Nimble
@testable import SwiftHub

class RecordTests: QuickSpec {
    override func spec() {
        let id = 1
        let quarter = "2004-Q4"
        let volumeOfMobileData = "0.000543"
        let volume = NSDecimalNumber(string: "0.000543")
        describe("converts from JSON") {
            it("Record") {
                let data: [String: Any] = ["_id": id, "quarter": quarter, "volume_of_mobile_data": volumeOfMobileData]
                let record = Record(JSON: data)
                expect(record?.id) == id
                expect(record?.quarter) == quarter
                expect(record?.volumeOfMobileData) == volumeOfMobileData
                expect(record?.volume) == volume
            }
        }
    }
}

class YearRecordTests: QuickSpec {
    override func spec() {

        var record1 = Record()
        record1.id = 1
        record1.quarter = "2005-Q1"
        record1.volumeOfMobileData = "0.000563"

        var record2 = Record()
        record2.id = 2
        record2.quarter = "2005-Q2"
        record2.volumeOfMobileData = "0.000537"

        var record3 = Record()
        record3.id = 3
        record3.quarter = "2005-Q3"
        record3.volumeOfMobileData = "0.000543"
        let records = [record1, record2, record3]
        let decrease: Bool = true
        let year = "2005"
        let value1 = NSDecimalNumber(string: "0.000563")
        let value2 = NSDecimalNumber(string: "0.000537")
        let value3 = NSDecimalNumber(string: "0.000543")
        let sum = value1.adding(value2).adding(value3)
        let volumeOfMobileData: String? = sum.description

        describe("YearRecord Init") {
            it("YearRecord ") {
                let yearRecord = YearRecord(records: records, year: year)
                expect(yearRecord.decrease) == decrease
                expect(yearRecord.year) == year
                expect(yearRecord.volumeOfMobileData) == volumeOfMobileData
            }
        }
        var record4 = Record()
        record4.id = 3
        record4.quarter = "2006-Q1"
        record4.volumeOfMobileData = "0.00543"
        let records2 = [record1, record2, record3, record4]
        describe("YearRecord convertToYearRecords") {
            it("save and remove user") {
                let yearRecords = YearRecord.convertToYearRecords(records: records2)
                expect(yearRecords).to(haveCount(2))
            }
        }
    }
}

class SphTests: QuickSpec {
    
    
}
