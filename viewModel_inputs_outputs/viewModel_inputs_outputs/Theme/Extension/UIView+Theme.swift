//
//  UIView+Theme.swift
//  YoegameSdk
//
//  Created by 林京賢 on 2024/5/20.
//

import UIKit

extension ThemeProxy where Base: UIView {
    
    var backgroundColor: ((ThemeType) -> UIColor?)? {
        get {
            fatalError("getter has not been implemented")
        }
        set {
            let key = "\(Self.self)_\(#function)"
            addTheme(key, value: (newValue == nil) ? nil : { [weak self] in
                self?.base?.backgroundColor = newValue?($0) ?? self?.base?.backgroundColor
            })
        }
    }
}
