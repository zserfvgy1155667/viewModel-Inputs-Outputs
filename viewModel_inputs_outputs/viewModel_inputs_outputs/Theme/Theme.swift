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
    
    #warning("mike-之後再補顏色等設定。")
    
    var image: ImageTheme {
        switch self {
        case .light:
            return LightImageTheme()
        case .dark:
            return DarkImageTheme()
        }
    }
}

/// 直接拉圖片的參數
var ImageList = ThemeManager.shared.type.image
