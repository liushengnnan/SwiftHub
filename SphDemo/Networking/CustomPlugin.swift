//
//  CustomPlugin.swift
//  SwiftHub
//
//  Created by shengnan liu on 15/5/20.
//  Copyright © 2020 Khoren Markosyan. All rights reserved.
//

import Foundation
import Moya

final class CustomPlugin: PluginType {

    func willSend(_ request: RequestType, target: TargetType) {
        print("CustomPlugin willSend")
        print(request)
    }

    func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        print("CustomPlugin didReceive")
        print(result)
    }
}
