//
//  UIButton+Theme.swift
//  YoegameSdk
//
//  Created by 林京賢 on 2024/5/20.
//

import UIKit

extension ThemeProxy where Base: UIButton {
    
    func setTitle(_ newValue: ((LocalizationList) -> String?)?, for state: UIControl.State) {
        let key = "\(Self.self)_\(#function)_\(state.rawValue)"
        addLanguage(key, value: (newValue == nil) ? nil : { [weak self] in
            self?.base?.setTitle(newValue?($0.languaged) ?? "", for: state)
        })
    }
    
    func setTitleColor(_ newValue: ((ThemeType) -> UIColor?)?, for state: UIControl.State) {
        let key = "\(Self.self)_\(#function)_\(state.rawValue)"
        addTheme(key, value: (newValue == nil) ? nil : { [weak self] in
            self?.base?.setTitleColor(newValue?($0), for: state)
        })
    }
    
    func setImage(_ newValue: ((ThemeType) -> String?)?, color: UIColor? = nil, for state: UIControl.State) {
        let key = "\(Self.self)_\(#function)_\(state.rawValue)"
        addTheme(key, value: (newValue == nil) ? nil : { [weak self] in
            
            let image = newValue?($0)?.toImage()
            
            if let color = color {
                self?.base?.setImage(image?.withColor(color), for: state)
            }
            else {
                self?.base?.setImage(image, for: state)
            }
        })
    }
    
    func setBackgroundImage(_ newValue: ((ThemeType) -> String?)?, color: UIColor? = nil, for state: UIControl.State) {
        let key = "\(Self.self)_\(#function)_\(state.rawValue)"
        addTheme(key, value: (newValue == nil) ? nil : { [weak self] in
            
            let image = newValue?($0)?.toImage()
            
            if let color = color {
                self?.base?.setBackgroundImage(image?.withColor(color), for: state)
            }
            else {
                self?.base?.setBackgroundImage(image, for: state)
            }
        })
    }
    
    var tintColor: ((ThemeType) -> UIColor?)? {
        get {
            fatalError("getter has not been implemented")
        }
        set {
            let key = "\(Self.self)_\(#function)"
            addTheme(key, value: (newValue == nil) ? nil : { [weak self] in
                self?.base?.tintColor = newValue?($0) ?? self?.base?.tintColor
            })
        }
    }
}
