//
//  CardType.swift
//  viewModel_inputs_outputs
//
//  Created by 林京賢 on 2024/5/5.
//

/// 卡片類型
enum CardType: CaseIterable {
    
    /// 剪刀
    case scissor
    /// 石頭
    case stone
    /// 布
    case paper
    
    
    /// 文字
    var text: String {
        switch self {
        case .paper:
            return "✋🏼"
        case .scissor:
            return "✌🏼"
        case .stone:
            return "✊🏼"
        }
    }
    
    // 每局結果
    func getGameTurnResult(_ type: CardType) -> GameTurnResult {
        
        if self == type {
            return .draw
        }
        
        switch (self, type) {
        case (.stone, .scissor), (.paper, .stone), (.scissor, .paper):
            return .win
        default:
            return .lost
        }
    }
}
