//
//  UITextField+Theme.swift 
//  YoegameSdk
//
//  Created by 林京賢 on 2024/5/21.
//

import UIKit

extension ThemeProxy where Base: UITextField {
    
    var text: ((LocalizationList) -> String?)? {
        get {
            fatalError("getter has not been implemented")
        }
        set {
            let key = "\(Self.self)_\(#function)"
            addLanguage(key, value: (newValue == nil) ? nil : { [weak self] in
                self?.base?.text = newValue?($0.languaged) ?? self?.base?.text
            })
        }
    }
    
    var placeHolder: ((LocalizationList) -> String?)? {
        get {
            fatalError("getter has not been implemented")
        }
        set {
            let key = "\(Self.self)_\(#function)"
            addLanguage(key, value: (newValue == nil) ? nil : { [weak self] in
                self?.base?.placeholder = newValue?($0.languaged) ?? self?.base?.placeholder
            })
        }
    }
    
    var textColor: ((ThemeType) -> UIColor?)? {
        get {
            fatalError("getter has not been implemented")
        }
        set {
            let key = "\(Self.self)_\(#function)"
            addTheme(key, value: (newValue == nil) ? nil : { [weak self] in
                self?.base?.textColor = newValue?($0) ?? self?.base?.textColor
            })
        }
    }
}
