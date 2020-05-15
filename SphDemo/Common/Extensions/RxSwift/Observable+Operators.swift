//
//  Observable+Operators.swift
//  Cake Builder
//
//  Created by Khoren Markosyan on 10/19/16.
//  Copyright © 2016 Khoren Markosyan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: UIView {
    func tap() -> Observable<Void> {
        return tapGesture().when(.recognized).mapToVoid()
    }
}

extension ObservableType {
    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }
}
