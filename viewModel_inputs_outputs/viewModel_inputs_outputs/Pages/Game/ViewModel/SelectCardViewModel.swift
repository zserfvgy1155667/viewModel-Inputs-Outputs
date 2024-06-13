//
//  SelectCardViewModel.swift
//  viewModel_inputs_outputs
//
//  Created by mike on 2024/5/7.
//

import UIKit


// 選擇卡片 viewModel
class SelectCardViewModel: SelectCardViewModelType, SelectCardViewModelInputs, SelectCardViewModelOutputs {
   
    typealias Input = SelectCardViewModelInputs
    typealias Output = SelectCardViewModelOutputs
    
    weak var inputs: Input? { self }
    weak var outputs: Output? { self }

    /// 紀錄卡片的分別數量 (key: 卡面類型, value: 數量)
    private var cardTypeMap = [CardType: Int]()
    
    private var items: [PickerCardItem] = []
    
    
    /// 卡牌類型最小數量
    private let typeMinCount: Int
    /// 總數量
    private let totalCount: Int
    
    
    /// 建構子
    /// - Parameters:
    ///   - typeMinCount: 卡牌類型最小數量
    ///   - totalCount: 產生多少數量的卡
    init(typeMinCount: Int, totalCount: Int) {
        
        let typeCount = CardType.allCases.count
        
        self.typeMinCount = typeMinCount
        self.totalCount = totalCount
        
        // 計算變數是否有錯誤。
        if (typeMinCount * typeCount) > totalCount {
            fatalError("初始設定數量不對，請重新設定！")
        }
    }
    
    
    // MARK: Output
    var updateItems: ((NSDiffableDataSourceSnapshot<SelectCardCollectionView.SectionType, Item>) -> Void)?
    var updateCardTip: (([CardType: Int]) -> Void)?
    
    
    // MARK: Input
    /// 選擇卡片藉由索引
    func selectCardByIndex(index: Int, playerName: String) {
        
        guard items.indices.contains(index),
              items[index].playerName == nil else {
            return
        }
        
        let cardType = items[index].cardType
        items[index].playerName = playerName
        items[index].isOpenCard = true
        
        applySnapshot()
    }
    
    /// 生成隨隨機卡片
    func createRandomCards() {
        
        if CardType.allCases.count == 0 {
            fatalError("類型錯誤，請重新設定！")
        }
        
        
        self.items = []
        
        
        let typeCount = CardType.allCases.count
        
        // 生成固定的卡片
        for index in 0..<typeCount {
            
            let type = CardType.allCases[index]
            
            cardTypeMap.updateValue(typeMinCount, forKey: type)
            items.append(contentsOf: (0..<typeMinCount).map({ _ in PickerCardItem(cardType: type) }))
        }
    
        // 生成隨機的卡片
        while items.count < totalCount {
            
            guard let type = CardType.allCases.randomElement() else {
                continue
            }
            
            items.append(PickerCardItem(cardType: type))
            
            if let count = cardTypeMap[type] {
                cardTypeMap.updateValue(count + 1, forKey: type)
            }
        }
        
        
        self.items = items.shuffled()
        
        // 回傳結果
        updateCardTip?(cardTypeMap)
        applySnapshot()
    }
    
    /// 打開全部的卡
    func allOpenCards() {
        
        for item in items {
            item.isOpenCard = true
        }
        
        applySnapshot()
    }
    
    /// 實作結果
    private func applySnapshot() {
        
        var snapshot = NSDiffableDataSourceSnapshot<SelectCardCollectionView.SectionType, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main)
        
        updateItems?(snapshot)
    }
}


// MARK: input/output
protocol SelectCardViewModelInputs: AnyObject {
    
    /// 生成隨隨機卡片
    func createRandomCards()
    
    /// 選擇卡片藉由索引
    func selectCardByIndex(index: Int, playerName: String)
    
    /// 打開全部的卡
    func allOpenCards()
}

protocol SelectCardViewModelOutputs: AnyObject {
            
    /// 更新項目
    var updateItems: ((NSDiffableDataSourceSnapshot<SelectCardCollectionView.SectionType, Item>) -> Void)? { get set }

    /// 更新卡片提示
    var updateCardTip: (([CardType: Int]) -> Void)? { get set }
}

protocol SelectCardViewModelType {
    var inputs: SelectCardViewModelInputs? { get }
    var outputs: SelectCardViewModelOutputs? { get }
}

