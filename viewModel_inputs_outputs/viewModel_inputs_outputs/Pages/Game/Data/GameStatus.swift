//
//  GameStatus.swift
//  viewModel_inputs_outputs
//
//  Created by mike on 2024/5/7.
//

/// 遊戲狀態
enum GameStatus: Equatable {
    
    /// 遊戲開始
    case start
    /// 該局贏
    case turnWin(playerName: String, isPkDone: Bool)
    /// 全贏
    case winner(playerName: String)
    /// 平手
    case draw
    
    
    /// 判斷是否相等
    static func == (lhs: GameStatus, rhs: GameStatus) -> Bool {

        switch (lhs, rhs) {
        case (turnWin(let lhsPlayerName, let lhsIsPkDone), turnWin(let rhsPlayerName, let rhsIsPkDone)):
            return lhsPlayerName == rhsPlayerName && lhsIsPkDone == rhsIsPkDone
        case (winner(let lhsPlayerName), winner(let rhsPlayerName)):
            return lhsPlayerName == rhsPlayerName
        case (.start, .start),
            (.draw, .draw):
            return true
        default:
            return false
        }
    }
}
