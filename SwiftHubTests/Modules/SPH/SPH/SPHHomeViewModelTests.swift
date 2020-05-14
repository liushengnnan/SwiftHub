//
//  SPHHomeViewModelTests.swift
//  SwiftHubTests
//
//  Created by shengnan liu on 14/5/20.
//  Copyright © 2020 Khoren Markosyan. All rights reserved.
//

import Quick
import Nimble
import RxSwift
@testable import SwiftHub

class SPHHomeViewModelTests: QuickSpec {
    override func spec() {
        var viewModel: SPHHomeViewModel!
        var provider: SwiftHubAPI!  // used stubbing responses
        var disposeBag: DisposeBag!

        beforeEach {
            provider = RestApi(githubProvider: GithubNetworking.stubbingNetworking(),
                               trendingGithubProvider: TrendingGithubNetworking.stubbingNetworking(),
                               codetabsProvider: CodetabsNetworking.stubbingNetworking(),
                               sphProvider: SphNetworking.stubbingNetworking())
            disposeBag = DisposeBag()
        }

        afterEach {
            viewModel = nil // Force viewModel to deallocate and stop syncing.
        }
        
        describe("users list from profile") {
            it("followers") {
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
        expect(output.items.value.count) == 0
        expect(viewModel.page) == 1
    }
}
