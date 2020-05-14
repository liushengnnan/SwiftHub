//
//  Api.swift
//  SwiftHub
//
//  Created by Khoren Markosyan on 1/5/18.
//  Copyright © 2018 Khoren Markosyan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol SphApiProtocol {
    // MARK: - SPH
    func datastoreSearch(id: String, limit: Int?, quary: String?) -> Single<Sph>
}

protocol SwiftHubAPI: SphApiProtocol {
    // Add More ApiProtocol
}
