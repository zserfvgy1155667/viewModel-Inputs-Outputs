//
//  GameViewController.swift
//  viewModel_inputs_outputs
//
//  Created by 林京賢 on 2024/5/5.
//

import UIKit

/// 遊戲頁面
class GameViewController: BaseViewController {

    /// 卡片提示
    @IBOutlet weak var cardTipCollectionView: CardTipCollectionView!
    /// 選擇卡片
    @IBOutlet weak var selectCardCollectionView: SelectCardCollectionView!
    /// 玩家清單
    @IBOutlet weak var playerTipCollectionView: PlayerTipCollectionView!
    
    
    let viewModel: GameViewModel
    
    
    /// 建構子
    /// - Parameters:
    ///   - playerNames: 玩家名稱
    ///   - pkRaceCount: 需要 pk 的勝局次數
    ///   - pkPlayerCount: 需要 pk 的玩家數量
    ///   - cardTypeMinCount: 卡片每個類型的最小數量
    ///   - cardTotalCount: 卡片總數量
    init(
        playerNames: [String],
        pkRaceCount: Int,
        pkPlayerCount: Int,
        cardTypeMinCount: Int,
        cardTotalCount: Int
    ) {
        viewModel = .init(
            playerNames: playerNames,
            pkRaceCount: pkRaceCount,
            pkPlayerCount: pkPlayerCount,
            cardTypeMinCount: cardTypeMinCount,
            cardTotalCount: cardTotalCount
        )
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
        
        viewModel.outputs?.cardTipItems = { [weak self] in
            self?.cardTipCollectionView.customDataSource.apply($0) { [weak self] in
                self?.cardTipCollectionView.reloadData()
                self?.cardTipCollectionView.collectionViewLayout.invalidateLayout()
            }
        }
        
        viewModel.outputs?.selectCardItems = { [weak self] in
            self?.selectCardCollectionView.customDataSource.apply($0) { [weak self] in
                self?.selectCardCollectionView.reloadData()
                self?.selectCardCollectionView.collectionViewLayout.invalidateLayout()
            }
        }
        
        viewModel.outputs?.playerTipItems = { [weak self] in
            self?.playerTipCollectionView.customDataSource.apply($0) { [weak self] in
                self?.playerTipCollectionView.reloadData()
                self?.playerTipCollectionView.collectionViewLayout.invalidateLayout()
            }
        }
        
        selectCardCollectionView.onCardTap = { [weak self] in
            self?.viewModel.inputs?.pickCardDone(itemIndex: $0.itemIndex, cardType: $0.cardType)
        }
        playerTipCollectionView.onTextButtonTap = { [weak self] in
            self?.viewModel.inputs?.tapTextButton()
        }
        
        
        viewModel.inputs?.viewDidLoad()
    }
}
