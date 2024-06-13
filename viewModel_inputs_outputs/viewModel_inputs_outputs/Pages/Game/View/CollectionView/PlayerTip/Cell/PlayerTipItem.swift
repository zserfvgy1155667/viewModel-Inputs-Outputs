//
//  PlayerTipItem.swift
//  viewModel_inputs_outputs
//
//  Created by mike on 2024/5/7.
//

import UIKit

/// 玩家提示
class PlayerTipItem: Item {
    
    override var identifier: String {
        UUID().uuidString
    }
    
    
    var playerTextColor: UIColor {
        isMyTurn ? .white : .black
    }
    
    var raceCountTextColor: UIColor {
        isMyTurn ? .white : .black
    }
    
    var backgroundColor: UIColor {
        isMyTurn ? .red.withAlphaComponent(0.6) : .clear
    }
    
    var raceCountText: String {
        "勝局次數: \(raceCount)"
    }
    
    /// 玩家名稱
    var playerName: String
    /// 需要勝局的次數
    var raceCount: Int
    /// 我的回合
    var isMyTurn: Bool
    
    
    init(playerName: String, raceCount: Int, isMyTurn: Bool = false) {
        self.playerName = playerName
        self.isMyTurn = isMyTurn
        self.raceCount = raceCount
    }
    
    override func hash(into hasher: inout Hasher) {
        hasher.combine(playerName)
        hasher.combine(isMyTurn)
        hasher.combine(raceCount)
        super.hash(into: &hasher)
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        let i = toSelfObject(object)
        return super.isEqual(object) &&
        playerName == i?.playerName &&
        isMyTurn == i?.isMyTurn &&
        raceCount == i?.raceCount
    }
}


