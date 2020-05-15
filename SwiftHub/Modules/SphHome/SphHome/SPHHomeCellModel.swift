//
//  SPHHomeCellModel.swift
//  SwiftHub
//
//  Created by shengnan liu on 13/5/20.

//

import Foundation
import RxSwift
import RxCocoa

class SPHHomeCellModel: DefaultTableViewCellViewModel {
    let record: YearRecord
    init(with record: YearRecord) {
        self.record = record
        super.init()
        title.accept(record.volumeOfMobileData)
        detail.accept(record.year)
        image.accept(R.image.icon_cell_star()?.template)
        hidesDisclosure.accept(!record.decrease)
    }
}
