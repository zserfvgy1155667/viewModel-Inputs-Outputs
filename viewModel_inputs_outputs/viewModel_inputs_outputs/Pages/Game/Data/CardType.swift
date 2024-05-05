//
//  CardType.swift
//  viewModel_inputs_outputs
//
//  Created by 林京賢 on 2024/5/5.
//

/// 卡片類型
enum CardType {
    
    /// 布
    case paper
    /// 剪刀
    case scissor
    /// 石頭
    case stone
    
    
    /// 文字
    var text: String {
        switch self {
        case .paper:
            return "布"
        case .scissor:
            return "剪刀"
        case .stone:
            return "石頭"
        }
    }
}
