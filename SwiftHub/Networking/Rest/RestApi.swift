//
//  RestApi.swift
//  SwiftHub
//
//  Created by Sygnoos9 on 3/9/19.
//  Copyright © 2019 Khoren Markosyan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import ObjectMapper
import Moya
import Moya_ObjectMapper
import Alamofire

typealias MoyaError = Moya.MoyaError

class RestApi: NetAPI {
    let sphProvider: SphNetworking
    init(sphProvider: SphNetworking) {
        self.sphProvider = sphProvider
    }
}

extension RestApi {
    private func sphRequestObject<T: BaseMappable>(_ target: SphApi, type: T.Type) -> Single<T> {
        return sphProvider.request(target)
            .mapObject(T.self)
            .observeOn(MainScheduler.instance)
            .asSingle()
    }
}

extension RestApi: SphApiProtocol {
    func datastoreSearch(id: String, limit: Int?, quary: String?) -> Single<Sph> {
        return sphRequestObject(.datastoreSearch(id: id, limit: limit, quary: quary), type: Sph.self)
    }
}
