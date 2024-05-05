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
    
    
    init(type: ThemeType = .light) {
        self.type = type
    }
    
    #warning("mike-之後再補注冊監聽等設定。")
}
