//
//  SPHHomeCell.swift
//  SwiftHub
//
//  Created by shengnan liu on 14/5/20.

//

import UIKit
import Toast_Swift

class SPHHomeCell: DefaultTableViewCell {

    override func makeUI() {
        super.makeUI()
        leftImageView.contentMode = .center
    }

    override func bind(to viewModel: TableViewCellViewModel) {
        super.bind(to: viewModel)
        guard let viewModel = viewModel as? SPHHomeCellModel else { return }
        rightImageView.rx.tap().subscribe(onNext: { () in
            var style = ToastManager.shared.style
            style.backgroundColor =  UIColor.Material.green
            style.maxHeightPercentage = 0.5
            let message = viewModel.record.quarters?.toJSONString()
            UIApplication.shared.keyWindow?.makeToast(message)

        }).disposed(by: rx.disposeBag)
    }
}
