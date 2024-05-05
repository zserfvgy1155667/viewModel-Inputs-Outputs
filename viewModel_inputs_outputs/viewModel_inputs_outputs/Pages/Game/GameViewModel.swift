//
//  GameViewModel.swift
//  viewModel_inputs_outputs
//
//  Created by 林京賢 on 2024/5/5.
//

/// viewModel 委派
protocol GameViewModelDelegate: AnyObject {

}


// viewModel
class GameViewModelModel: GameViewModelType, GameViewModelInputs, GameViewModelOutputs {
   
    typealias Input = GameViewModelInputs
    typealias Output = GameViewModelOutputs

    
    weak var delegate: GameViewModelDelegate?
    
    weak var inputs: Input? { self }
    weak var outputs: Output? { self }
    
    /// 玩家總數量
    var playerTotalCount: Int {
        playerNames.count
    }
    
    // MARK: Output
    /// 目前玩家數量
    private let playerNames: [String]
    
    
    init(playerNames: [String]) {
        self.playerNames = playerNames
    }
    
    // MARK: Input
    
}


// MARK: input/output
protocol GameViewModelInputs: AnyObject {
        
}

protocol GameViewModelOutputs: AnyObject {
        
//    /// 取得輸入焦點
//    var focusInput: (() -> Void)? { get set }
//    /// 更新輸入文字
//    var updateInputText: ((String) -> Void)? { get set }
}

protocol GameViewModelType {
    var inputs: GameViewModelInputs? { get }
    var outputs: GameViewModelOutputs? { get }
}



