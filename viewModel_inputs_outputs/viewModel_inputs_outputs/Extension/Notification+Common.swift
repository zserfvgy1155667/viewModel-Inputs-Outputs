//
//  Notification+Common.swift
//  viewModel_inputs_outputs
//
//  Created by 林京賢 on 2024/6/16.
//

import Foundation

extension NSNotification.Name {
    
    /// 面板顏色/圖片更換事件
    static var NT_themeChanged = NSNotification.Name(rawValue: "NT_themeChanged")
    /// 語系變更事件
    static var NT_LanguageChanged = NSNotification.Name(rawValue: "NT_LanguageChanged")
}
