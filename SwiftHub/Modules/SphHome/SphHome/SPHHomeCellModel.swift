//
//  SPHHomeCellModel.swift
//  SwiftHub
//
//  Created by shengnan liu on 13/5/20.
//  Copyright © 2020 Khoren Markosyan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SPHHomeCellModel: DefaultTableViewCellViewModel {
    let record: YearRecord
    init(with record: YearRecord) {
        self.record = record
        super.init()
        title.accept(record.year)
        detail.accept(record.volumeOfMobileData)
        if record.decrease {
            image.accept(R.image.icon_cell_git_branch()?.template)
        }
    }
}
