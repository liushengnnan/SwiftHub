//
//  GraphApi.swift
//  SwiftHub
//
//  Created by Sygnoos9 on 3/9/19.
//  Copyright © 2019 Khoren Markosyan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Apollo

class GraphApi: SwiftHubAPI {

    let restApi: RestApi
    let token: String

    private lazy var networkTransport: HTTPNetworkTransport = {
      let transport = HTTPNetworkTransport(url: URL(string: "https://api.github.com/graphql")!)
      transport.delegate = self
      return transport
    }()

    private(set) lazy var client = ApolloClient(networkTransport: self.networkTransport)

    init(restApi: RestApi, token: String) {
        self.restApi = restApi
        self.token = token
    }
}

extension GraphApi: HTTPNetworkTransportPreflightDelegate {
    func networkTransport(_ networkTransport: HTTPNetworkTransport, shouldSend request: URLRequest) -> Bool {
        return true
    }

    func networkTransport(_ networkTransport: HTTPNetworkTransport, willSend request: inout URLRequest) {
        var headers = request.allHTTPHeaderFields ?? [String: String]()
        headers["Authorization"] = "Bearer \(token)"
        request.allHTTPHeaderFields = headers
    }
}

extension GraphApi {
    func datastoreSearch(id: String, limit: Int?, quary: String?) -> Single<Sph> {
        return restApi.datastoreSearch(id: id, limit: limit, quary: quary)
    }
}

extension GraphApi {
    private func ownerName(from fullname: String) -> String {
        return fullname.components(separatedBy: "/").first ?? ""
    }

    private func repoName(from fullname: String) -> String {
        return fullname.components(separatedBy: "/").last ?? ""
    }
}
