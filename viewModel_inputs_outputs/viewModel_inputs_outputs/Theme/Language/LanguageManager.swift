//
//  LanguageManager.swift
//  viewModel_inputs_outputs
//
//  Created by 林京賢 on 2024/6/13.
//

import Foundation
import UIKit

/// 語言管理者
class LanguageManager {
    
    static var shared: LanguageManager { _shared }
    private static var _shared = LanguageManager()
    
    private(set) var type: LanguageType
    
    init(list: LanguageList = .systemSetting) {
        self.type = list.type
    }
    
    func updateLanguage() {
        NotificationCenter.default.post(name: .NT_LanguageChanged, object: type)
    }
    
    /// 註冊監聽事件
    func addObserver(_ observer: Any, selector aSelector: Selector) {
        NotificationCenter.default.addObserver(observer, selector: aSelector, name: .NT_LanguageChanged, object: nil)
    }
    
    /// 註冊 action 監聽事件
    func addObserver(action: ThemeAction) {
        NotificationCenter.default.addObserver(action, selector: #selector(action.action(notification:)), name: .NT_LanguageChanged, object: nil)
    }
    
    /// 移除 action 監聽事件
    func removeObserver(action: ThemeAction) {
        NotificationCenter.default.removeObserver(action, name: .NT_LanguageChanged, object: nil)
    }
    
    func switchLanguage(_ list: LanguageList) {
        self.type = list.type
        
        StringList = list.type.languaged
        NotificationCenter.default.post(name: .NT_LanguageChanged, object: list.type)
    }
}

enum LanguageType: String {
    case vi,ko,th,en,ja,zhHant,id,zhHans
    
    var languaged: LocalizationList {
        return LocalizationList()
    }
}

var StringList = LanguageManager.shared.type.languaged
