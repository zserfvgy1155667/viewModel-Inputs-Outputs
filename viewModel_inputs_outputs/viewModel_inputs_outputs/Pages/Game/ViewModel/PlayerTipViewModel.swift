//
//  PlayerTipViewModel.swift
//  viewModel_inputs_outputs
//
//  Created by mike on 2024/5/7.
//

import UIKit


// 玩家提示 viewModel
class PlayerTipViewModel: PlayersViewModelType, PlayersViewModelInputs, PlayersViewModelOutputs {
       
    typealias Input = PlayersViewModelInputs
    typealias Output = PlayersViewModelOutputs
    
    
    weak var inputs: Input? { self }
    weak var outputs: Output? { self }

    
    private var items: [Item] = []
    
    
    // MARK: Output
    var updateItems: ((NSDiffableDataSourceSnapshot<PlayerTipCollectionView.SectionType, Item>) -> Void)?
    
    
    // MARK: Input
    /// 初始化玩家提示
    func initPlayerTip(pkRaceCountInfo: [String: Int]) {
        
        var items: [PlayerTipItem] = []
        for (playerName, raceCount) in pkRaceCountInfo {
            items.append(PlayerTipItem(playerName: playerName, raceCount: raceCount))
        }
        // 第一個先選卡片
        items.first?.isMyTurn = true
        
        
        self.items = items
        
        applySnapshot(.playerTip)
    }
    
    /// 重置每局玩家 (平手會得到)
    func resetTurnPlayer() {
        
        guard let index = getCurrentPlayerTurn()?.index,
              let items = self.items as? [PlayerTipItem] else {
            
            return
        }
        
        items[index].isMyTurn = false
        items[0].isMyTurn = true
        
        applySnapshot(.playerTip)
    }
    
    /// 下一個要選牌的玩家
    func nextPickPlayer() {
        
        guard let index = getCurrentPlayerTurn()?.index,
              let items = self.items as? [PlayerTipItem],
              items.indices.contains(index + 1) else {
            
            return
        }
        
        items[index].isMyTurn = false
        items[index + 1].isMyTurn = true
        
        applySnapshot(.playerTip)
    }
    
    /// 顯示結果
    func showGameResult(_ status: GameStatus) {
        
        items = [TextButtonItem(status)]
        applySnapshot(.textButton)
    }
    
    /// 取得玩家回合索引資訊
    func getCurrentPlayerTurn() -> (index: Int, playerName: String)? {
        
        guard let items = self.items as? [PlayerTipItem] else {
           return nil
        }
        
        let index = items.firstIndex(where: { $0.isMyTurn })
        return (index == nil) ? nil : (index: index!, playerName: items[index!].playerName)
    }
    
    /// 實作結果
    private func applySnapshot(_ sectionType: PlayerTipCollectionView.SectionType) {
        
        var snapshot = NSDiffableDataSourceSnapshot<PlayerTipCollectionView.SectionType, Item>()
        snapshot.appendSections([sectionType])
        snapshot.appendItems(items, toSection: sectionType)
        
        updateItems?(snapshot)
    }
}


// MARK: input/output
protocol PlayersViewModelInputs: AnyObject {
    
    /// 初始化玩家提示
    func initPlayerTip(pkRaceCountInfo: [String: Int])
    
    /// 重置每局玩家 (平手會得到)
    func resetTurnPlayer()
    
    /// 下一個要選牌的玩家
    func nextPickPlayer()
    
    /// 顯示結果
    func showGameResult(_ result: GameStatus)
    
    /// 取得玩家回合索引
    func getCurrentPlayerTurn() -> (index: Int, playerName: String)?
}

protocol PlayersViewModelOutputs: AnyObject {
            
    /// 更新項目
    var updateItems: ((NSDiffableDataSourceSnapshot<PlayerTipCollectionView.SectionType, Item>) -> Void)? { get set }
}

protocol PlayersViewModelType {
    var inputs: PlayersViewModelInputs? { get }
    var outputs: PlayersViewModelOutputs? { get }
}
