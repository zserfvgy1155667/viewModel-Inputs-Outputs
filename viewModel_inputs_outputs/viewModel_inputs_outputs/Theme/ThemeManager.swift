//
//  ThemeManager.swift
//  viewModel_inputs_outputs
//
//  Created by 林京賢 on 2024/5/5.
//

import Foundation

/// 主題管理者
class ThemeManager {
    
    static var shared: ThemeManager { _shared }
    private static var _shared = ThemeManager()
    
    private(set) var type: ThemeType
    
    private var timer: Timer?
    
    
    init(type: ThemeType = .light) {
        self.type = type
    }
    
    func updateTheme() {
        NotificationCenter.default.post(name: .NT_themeChanged, object: type)
    }
    
    /// 註冊監聽事件
    func addObserver(_ observer: Any, selector aSelector: Selector) {
        NotificationCenter.default.addObserver(
            observer,
            selector: aSelector,
            name: .NT_themeChanged,
            object: nil
        )
    }
    
    /// 註冊 action 監聽事件
    func addObserver(action: ThemeAction) {
        NotificationCenter.default.addObserver(
            action,
            selector: #selector(action.action(notification:)),
            name: .NT_themeChanged,
            object: nil
        )
    }
    
    /// 移除 action 監聽事件
    func removeObserver(action: ThemeAction) {
        NotificationCenter.default.removeObserver(
            action,
            name: .NT_themeChanged,
            object: nil
        )
    }
    
    func switchTheme(_ type: ThemeType) {
            
        if self.type == type {
            return
        }
        
        self.type = type
        ColorList = type.color
        ImageList = type.image
        
        // Timer 實現 debounce，減少觸發次數。
        timer?.invalidate()
        timer = nil
        timer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: false) { _ in
            NotificationCenter.default.post(name: .NT_themeChanged, object: type)
        }
    }
}
