//
//  BaseCoordinatorResultType.swift
//  viewModel_inputs_outputs
//
//  Created by 林京賢 on 2024/5/5.
//


/// BaseCoordinator 泛型回傳類型
/// 統一參數
enum BaseCoordinatorResultType/*: Route */ {
    /// 無
    case none
    /// 退回上一頁
    case back
    /// 切換到頁面
    case game(playerName: [String])
}

// MARK: extension Equatable
extension BaseCoordinatorResultType: Equatable {
    
    /// 判斷是否相等
    static func == (lhs: BaseCoordinatorResultType, rhs: BaseCoordinatorResultType) -> Bool {

        switch (lhs, rhs) {
        case (.none, .none),
            (.back, .back),
            (.game, .game):
            return true
        default:
            return false
        }
    }
}
