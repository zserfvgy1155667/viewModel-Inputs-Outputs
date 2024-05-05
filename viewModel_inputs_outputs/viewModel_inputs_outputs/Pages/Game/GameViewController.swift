//
//  GameViewController.swift
//  viewModel_inputs_outputs
//
//  Created by 林京賢 on 2024/5/5.
//

import UIKit

/// 遊戲頁面
class GameViewController: BaseViewController {

    
    let viewModel: GameViewModelModel
    
    
    init(playerNames: [String]) {
        viewModel = .init(playerNames: playerNames)
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackPresentRootViewController()
    }
    
    /// 初始化介面
    override func initUI() {
        title = "\(viewModel.playerTotalCount)人對戰"
    }
    
    /// 開始綁定
    override func setupBindings() {
    }
}
