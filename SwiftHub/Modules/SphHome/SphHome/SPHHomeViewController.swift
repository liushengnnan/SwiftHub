//
//  SPHHomeViewController.swift
//  SwiftHub
//
//  Created by shengnan liu on 13/5/20.

//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

private let reuseIdentifier = R.reuseIdentifier.sphHomeCell.identifier

class SPHHomeViewController: TableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func makeUI() {
        super.makeUI()

        languageChanged.subscribe(onNext: { [weak self] () in
            self?.title = R.string.localizable.sphHome.key.localized()
        }).disposed(by: rx.disposeBag)

        tableView.register(R.nib.sphHomeCell)
        tableView.footRefreshControl = nil

    }

    override func bindViewModel() {
        super.bindViewModel()
        guard let viewModel = viewModel as? SPHHomeViewModel else { return }

        let refresh = Observable.of(Observable.just(()), headerRefreshTrigger).merge()
        let input = SPHHomeViewModel.Input(selection: tableView.rx.modelSelected(SPHHomeCellModel.self).asDriver(),
                                           headerRefresh: refresh)
        let output = viewModel.transform(input: input)

        viewModel.loading.asObservable().bind(to: isLoading).disposed(by: rx.disposeBag)
        viewModel.headerLoading.asObservable().bind(to: isHeaderLoading).disposed(by: rx.disposeBag)
        viewModel.footerLoading.asObservable().bind(to: isFooterLoading).disposed(by: rx.disposeBag)

        output.items.asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(cellIdentifier: reuseIdentifier, cellType: SPHHomeCell.self)) { _, viewModel, cell in
                cell.bind(to: viewModel)
        }.disposed(by: rx.disposeBag)
    }
}
