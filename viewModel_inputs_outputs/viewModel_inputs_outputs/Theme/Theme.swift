//
//  Theme.swift
//  viewModel_inputs_outputs
//
//  Created by 林京賢 on 2024/5/5.
//

import Foundation

/// 主題類型 (顏色、圖片等)
enum ThemeType {
    
    case light
    case dark
    
    /// 顏色
    var color: ColorTheme {
        switch self {
        case .light:
            return LightColorTheme()
        case .dark:
            return DarkColorTheme()
        }
    }
    
    /// 圖片
    var image: ImageTheme {
        switch self {
        case .light:
            return LightImageTheme()
        case .dark:
            return DarkImageTheme()
        }
    }
}

/// 直接拉圖片/顏色的參數
var ImageList = ThemeManager.shared.type.image
var ColorList = ThemeManager.shared.type.color
