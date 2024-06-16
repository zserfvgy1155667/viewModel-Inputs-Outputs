//
//  UIImageView+Theme.swift
//  YoegameSdk
//
//  Created by 林京賢 on 2024/5/21.
//

import UIKit

extension ThemeProxy where Base: UIImageView {
    
    var image: ((ThemeType) -> String?)? {
        get {
            fatalError("getter has not been implemented")
        }
        set {
            let key = "\(Self.self)_\(#function)"
            addTheme(key, value: (newValue == nil) ? nil : { [weak self] in
                self?.base?.image = newValue?($0)?.toImage()
            }) 
        }
    }
}
