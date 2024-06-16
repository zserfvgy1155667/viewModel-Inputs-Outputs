//
//  ThemeAction.swift
//  viewModel_inputs_outputs
//
//  Created by 林京賢 on 2024/6/13.
//

import Foundation

/// 主題
class ThemeAction: NSObject {

    /// 主題
    var themes = [String: ((ThemeType) -> Void)]()
    /// 語言
    var languages = [String: ((LanguageType) -> Void)]()
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func action(notification: NSNotification) {
    
        if let type = notification.object as? LanguageType {
            languages.values.forEach({ $0(type) })
        }
        if let type = notification.object as? ThemeType {
            themes.values.forEach({ $0(type) })
        }
    }
}
