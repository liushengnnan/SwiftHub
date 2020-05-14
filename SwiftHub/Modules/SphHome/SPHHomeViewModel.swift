//
//  SPHHomeViewModel.swift
//  SwiftHub
//
//  Created by shengnan liu on 13/5/20.
//  Copyright © 2020 Khoren Markosyan. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import RxDataSources

class SPHHomeViewModel: ViewModel, ViewModelType {
    
    struct Input {
        let selection: Driver<SPHHomeCellModel>
        let headerRefresh: Observable<Void>
    }
    
    struct Output {
        let items: BehaviorRelay<[SPHHomeCellModel]>
    }
    
    func transform(input: Input) -> Output {
        let elements = BehaviorRelay<[SPHHomeCellModel]>(value: [])
        
        input.headerRefresh.flatMapLatest({ [weak self] () -> Observable<[SPHHomeCellModel]> in
            guard let self = self else { return Observable.just([]) }
            self.page = 1
            return self.request()
                .trackActivity(self.headerLoading)
        })
            .subscribe(onNext: { (items) in
                elements.accept(items)
            }).disposed(by: rx.disposeBag)
        
        return Output(items: elements)
    }
    func request() -> Observable<[SPHHomeCellModel]> {
        let id = "a807b7ab-6cad-4aa6-87d0-e283a7353a0f"
        return provider.datastoreSearch(id: id, limit: nil, quary: nil)
            .trackActivity(loading)
            .trackError(error)
            .map {
                let yearRecords = YearRecord.convertToYearRecords2(records: $0.result!.records!)
                return yearRecords.map({ (record) -> SPHHomeCellModel in
                    let viewModel = SPHHomeCellModel(with: record)
                    return viewModel
                })}
    }
}
