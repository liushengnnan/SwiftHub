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
import Kingfisher
import NVActivityIndicatorView
import NSObject_Rx
import RxViewController
import RxOptional
import RxGesture
import SwifterSwift
import Hero
import KafkaRefresh
import Toast_Swift

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
        }).disposed(by: rx.disposeBag)
    }

    func setupLibs(with window: UIWindow? = nil) {
        let libsManager = LibsManager.shared
        libsManager.setupTheme()
        libsManager.setupKafkaRefresh()
        libsManager.setupActivityView()
        libsManager.setupToast()
    }

    func setupTheme() {
        themeService.rx
            .bind({ $0.statusBarStyle }, to: UIApplication.shared.rx.statusBarStyle)
            .disposed(by: rx.disposeBag)
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
}

extension LibsManager {
    func removeKingfisherCache() -> Observable<Void> {
        return ImageCache.default.rx.clearCache()
    }

    func kingfisherCacheSize() -> Observable<Int> {
        return ImageCache.default.rx.retrieveCacheSize()
    }
}
