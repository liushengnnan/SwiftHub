//
//  UIColor+SwiftHub.swift
//  SwiftHub
//
//  Created by Khoren Markosyan on 1/4/17.
//  Copyright © 2017 Khoren Markosyan. All rights reserved.
//

import UIKit

// MARK: Colors

extension UIColor {

    static func primary() -> UIColor {
        return themeService.type.associatedObject.primary
    }

    static func primaryDark() -> UIColor {
        return themeService.type.associatedObject.primaryDark
    }

    static func secondary() -> UIColor {
        return themeService.type.associatedObject.secondary
    }

    static func secondaryDark() -> UIColor {
        return themeService.type.associatedObject.secondaryDark
    }

    static func separator() -> UIColor {
        return themeService.type.associatedObject.separator
    }

    static func text() -> UIColor {
        return themeService.type.associatedObject.text
    }
}
