//
//  SphApi.swift
//  SwiftHub
//
//  Created by shengnan liu on 13/5/20.
//  Copyright © 2020 Khoren Markosyan. All rights reserved.
//

import Foundation
import Moya

public enum SphApi {
    case datastoreSearch(id: String, limit: Int?, quary: String?)
}

extension SphApi: TargetType, ProductAPIType {
    public var baseURL: URL {
        return URL(string: "https://data.gov.sg")!
    }
    public var path: String {
        switch self {
        case .datastoreSearch: return "/api/3/action/datastore_search"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .datastoreSearch:
            return .get
        }
    }
    public var task: Task {
        if let parameters = parameters {
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
        return .requestPlain
    }
    public var headers: [String: String]? {
        return nil
    }

    public var parameters: [String: Any]? {
        var params: [String: Any] = [:]
        switch self {
        case .datastoreSearch(let id, let limit, let query):
            params["q"] = query
            params["resource_id"] = id
            params["limit"] = limit
        }
        return params
    }
//    public var sampleData: Data {
//       return "{}".data(using: String.Encoding.utf8)!
//    }

    public var sampleData: Data {
        var dataUrl: URL?
        switch self {
        case .datastoreSearch: dataUrl = R.file.repositoryNumberOfLinesJson()
        }
        if let url = dataUrl, let data = try? Data(contentsOf: url) {
            return data
        }
        return Data()
    }

    var addXAuth: Bool {
        switch self {
        default: return false
        }
    }
}