//
//  TextButtonItem.swift
//  viewModel_inputs_outputs
//
//  Created by mike on 2024/5/8.
//

import UIKit


/// 玩家提示
class TextButtonItem: Item {
    
    override var identifier: String {
        UUID().uuidString
    }
    
    
    /// 文字
    var text: String {
        gameStatus.text
    }
    
    /// 文字顏色
    var textColor: UIColor {
        gameStatus.textColor
    }
    
    /// 背景顏色
    var backgroundColor: UIColor {
        gameStatus.backgroundColor
    }
    
    
    /// 遊戲狀態
    var gameStatus: GameStatus
    
    
    init(_ gameStatus: GameStatus) {
        self.gameStatus = gameStatus
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        let i = toSelfObject(object)
        return super.isEqual(object) &&
        gameStatus == i?.gameStatus
    }
}

// MARK: extension GameStatus
fileprivate extension GameStatus {
    
    /// 背景顏色
    var backgroundColor: UIColor {
        
        switch self {
        case .turnWin:
            return .red.withAlphaComponent(0.6)
        case .winner:
            return .blue.withAlphaComponent(0.6)
        default:
            return .clear
        }
    }
    
    /// 文字顏色
    var textColor: UIColor {
        
        switch self {
        case .turnWin, .winner:
            return .white
        default:
            return .gray
        }
    }
    
    /// 文字
    var text: String {
        
        switch self {
        case .turnWin(let playerName, _):
            return "該局勝利者： \(playerName)"
        case .winner(let playerName):
            return "最終勝利者： \(playerName)"
        case .draw:
            return "該局平手"
        default:
            return ""
        }
    }
}

