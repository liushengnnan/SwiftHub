//
//  LibsManager.swift
//  SwiftHub
//
//  Created by Khoren Markosyan on 1/4/17.
//  Copyright © 2017 Khoren Markosyan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SnapKit
import IQKeyboardManagerSwift
import CocoaLumberjack
import Kingfisher
import Fabric
import Crashlytics
import NVActivityIndicatorView
import NSObject_Rx
import RxViewController
import RxOptional
import RxGesture
import SwifterSwift
import SwiftDate
import Hero
import KafkaRefresh
import Mixpanel
import Firebase
import DropDown
import Toast_Swift

typealias DropDownView = DropDown

/// The manager class for configuring all libraries used in app.
class LibsManager: NSObject {

    /// The default singleton instance.
    static let shared = LibsManager()

    let bannersEnabled = BehaviorRelay(value: UserDefaults.standard.bool(forKey: Configs.UserDefaultsKeys.bannersEnabled))

    override init() {
        super.init()

        if UserDefaults.standard.object(forKey: Configs.UserDefaultsKeys.bannersEnabled) == nil {
            bannersEnabled.accept(true)
        }

        bannersEnabled.skip(1).subscribe(onNext: { (enabled) in
            UserDefaults.standard.set(enabled, forKey: Configs.UserDefaultsKeys.bannersEnabled)
            analytics.set(.adsEnabled(value: enabled))
        }).disposed(by: rx.disposeBag)
    }

    func setupLibs(with window: UIWindow? = nil) {
        let libsManager = LibsManager.shared
        libsManager.setupCocoaLumberjack()
        libsManager.setupAnalytics()
        libsManager.setupTheme()
        libsManager.setupKafkaRefresh()
        libsManager.setupKeyboardManager()
        libsManager.setupActivityView()
        libsManager.setupDropDown()
        libsManager.setupToast()
    }

    func setupTheme() {
        themeService.rx
            .bind({ $0.statusBarStyle }, to: UIApplication.shared.rx.statusBarStyle)
            .disposed(by: rx.disposeBag)
    }

    func setupDropDown() {
        themeService.attrsStream.subscribe(onNext: { (theme) in
            DropDown.appearance().backgroundColor = theme.primary
            DropDown.appearance().selectionBackgroundColor = theme.primaryDark
            DropDown.appearance().textColor = theme.text
            DropDown.appearance().selectedTextColor = theme.text
            DropDown.appearance().separatorColor = theme.separator
        }).disposed(by: rx.disposeBag)
    }

    func setupToast() {
        ToastManager.shared.isTapToDismissEnabled = true
        ToastManager.shared.position = .top
        var style = ToastStyle()
        style.backgroundColor = UIColor.Material.red
        style.messageColor = UIColor.Material.white
        style.imageSize = CGSize(width: 20, height: 20)
        ToastManager.shared.style = style
    }

    func setupKafkaRefresh() {
        if let defaults = KafkaRefreshDefaults.standard() {
            defaults.headDefaultStyle = .replicatorAllen
            defaults.footDefaultStyle = .replicatorDot
            themeService.rx
                .bind({ $0.secondary }, to: defaults.rx.themeColor)
                .disposed(by: rx.disposeBag)
        }
    }

    func setupActivityView() {
        NVActivityIndicatorView.DEFAULT_TYPE = .ballRotateChase
        NVActivityIndicatorView.DEFAULT_COLOR = .secondary()
    }

    func setupKeyboardManager() {
        IQKeyboardManager.shared.enable = true
    }

    func setupCocoaLumberjack() {
        DDLog.add(DDOSLogger.sharedInstance)
        let fileLogger: DDFileLogger = DDFileLogger() // File Logger
        fileLogger.rollingFrequency = TimeInterval(60*60*24)  // 24 hours
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
        DDLog.add(fileLogger)
    }

    func setupAnalytics() {
        FirebaseApp.configure()
        Mixpanel.initialize(token: Keys.mixpanel.apiKey)
        Fabric.with([Crashlytics.self])
        Fabric.sharedSDK().debug = false
        FirebaseConfiguration.shared.setLoggerLevel(.min)
    }
}

extension LibsManager {
    func removeKingfisherCache() -> Observable<Void> {
        return ImageCache.default.rx.clearCache()
    }

    func kingfisherCacheSize() -> Observable<Int> {
        return ImageCache.default.rx.retrieveCacheSize()
    }
}
