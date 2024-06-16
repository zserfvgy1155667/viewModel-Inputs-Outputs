//
//  UIViewController+Theme.swift
//  YoegameSdk
//
//  Created by 林京賢 on 2024/5/21.
//

import UIKit

extension ThemeProxy where Base: UIViewController {
    
    var title: ((LocalizationList) -> String?)? {
        get {
            fatalError("getter has not been implemented")
        }
        set {
            let key = "\(Self.self)_\(#function)"
            addLanguage(key, value: (newValue == nil) ? nil : { [weak self] in
                self?.base?.title = newValue?($0.languaged) ?? self?.base?.title
            })
        }
    }
}
