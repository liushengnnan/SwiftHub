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

    let record: Record

    init(with record: Record) {
        self.record = record
        super.init()
        title.accept(record.quarter)
        detail.accept(record.volumeOfMobileData)
        image.accept(R.image.icon_cell_git_branch()?.template)
    }
}
