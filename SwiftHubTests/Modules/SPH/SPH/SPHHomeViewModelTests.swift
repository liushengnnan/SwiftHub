//
//  SPHHomeViewModelTests.swift
//  SwiftHubTests
//
//  Created by shengnan liu on 14/5/20.

//

import Quick
import Nimble
import RxSwift
@testable import SwiftHub

class SPHHomeViewModelTests: QuickSpec {
    override func spec() {
        var viewModel: SPHHomeViewModel!
        var provider: NetAPI!  // used stubbing responses
        var disposeBag: DisposeBag!

        beforeEach {
            provider = RestApi(sphProvider: SphNetworking.stubbingNetworking())
            disposeBag = DisposeBag()
        }

        afterEach {
            viewModel = nil // Force viewModel to deallocate and stop syncing.
        }
        
        describe("SPHHomeViewModel output") {
            it("SPHHomeViewModel") {
                let id = "a807b7ab-6cad-4aa6-87d0-e283a7353a0f"
                viewModel = SPHHomeViewModel(id: id, provider: provider)
                self.testViewModel(viewModel: viewModel, disposeBag: disposeBag)
            }
        }
    }
    
    func testViewModel(viewModel: SPHHomeViewModel, disposeBag: DisposeBag) {
        let headerRefresh = PublishSubject<Void>()
        let selection = PublishSubject<SPHHomeCellModel>()

        let input = SPHHomeViewModel.Input(selection: selection.asDriver(onErrorJustReturn: SPHHomeCellModel(with: YearRecord())), headerRefresh: headerRefresh)
        let output = viewModel.transform(input: input)

        // test pagination
        expect(output.items.value.count) == 0
        expect(viewModel.page) == 1
        headerRefresh.onNext(())
        expect(output.items.value.count) == 2
        expect(viewModel.page) == 1
    }
}
