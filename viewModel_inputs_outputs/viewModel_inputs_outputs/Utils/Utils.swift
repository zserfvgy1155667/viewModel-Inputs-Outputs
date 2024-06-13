//
//  Utils.swift
//  viewModel_inputs_outputs
//
//  Created by mike on 2024/5/9.
//

import Foundation

/// 共用資料
class Utils {
    static var shared: Utils { _shared }
    private static var _shared = Utils()
    
    static func reset() {
        _shared = Utils()
    }
    
    
    /// 最小玩家數量
    static let minPlayersCount: Int = 2
    /// 最大玩家數量
    static let maxPlayersCount: Int = 20
    
    /// 卡片每個類型的最小數量
    static let cardTypeMinCount: Int = 1
    /// 卡片總數量
    static let cardTotalCount: Int = 5
    /// pk 每局勝局次數
    static let pkRaceCount: Int = 1
    /// pk 人數
    static let pkPlayerCount: Int = 2
}
