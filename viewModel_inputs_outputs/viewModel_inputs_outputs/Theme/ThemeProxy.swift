//
//  ThemeProxy.swift
//  YoegameSdk
//
//  Created by 林京賢 on 2024/5/20.
//

import Foundation

public protocol ThemeCompatible: AnyObject {
    associatedtype CompatibleType: AnyObject
    var theme: ThemeProxy<CompatibleType> { get }
}

extension ThemeCompatible {
    
    /// 主題
    public var theme: ThemeProxy<Self> {
        get {
            if let local = withUnsafePointer(to: &AssociatedKey.theme, {
                objc_getAssociatedObject(self, $0) as? ThemeProxy<Self>
            }) {
                return local
            }
            
            // 要存本地，避免被釋放。
            let result = ThemeProxy<Self>(self)
            self.theme = result
            return result
        }
        set {
            withUnsafePointer(to: &AssociatedKey.theme) { [weak self] in
                guard let self = self else { return }
                objc_setAssociatedObject(self, $0, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
}

extension NSObject: ThemeCompatible {
}

private struct AssociatedKey {
    static var theme = "WKTheme"
}

public class ThemeProxy<Base: AnyObject>: NSObject {
    
    /// Base object to extend.
    weak var base: Base?

    /// Creates extensions with base object.
    ///
    /// - parameter base: Base object.
    public init(_ base: Base?) {
        self.base = base
    }
    
    
    private var _action: ThemeAction? {
        get {
            withUnsafePointer(to: &AssociatedKey.theme) {
                return objc_getAssociatedObject(self, $0) as? ThemeAction
            }
        }
        set {
            withUnsafePointer(to: &AssociatedKey.theme) { [weak self] in
                guard let self = self else { return }
                objc_setAssociatedObject(self, $0, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    
    /// 新增語系
    func addLanguage(_ key: String, value: ((LanguageType) -> Void)?) {
        
        let action = self._action ?? .init()
        
        guard let newValue = value else {
            action.languages.removeValue(forKey: key)
            return
        }
        
        action.languages.updateValue(newValue, forKey: key)
        
        // 註冊監聽
        LanguageManager.shared.removeObserver(action: action)
        LanguageManager.shared.addObserver(action: action)
        
        // 更新外部
        newValue(LanguageManager.shared.type)
        
        // 儲存
        self._action = action
    }
    
    /// 新增主題
    func addTheme(_ key: String, value: ((ThemeType) -> Void)?) {
        
        let action = self._action ?? .init()
        
        guard let newValue = value else {
            action.themes.removeValue(forKey: key)
            return
        }
        
        action.themes.updateValue(newValue, forKey: key)
        
        // 註冊監聽
        ThemeManager.shared.removeObserver(action: action)
        ThemeManager.shared.addObserver(action: action)
        
        // 更新外部
        newValue(ThemeManager.shared.type)
        
        self._action = action
    }
}
