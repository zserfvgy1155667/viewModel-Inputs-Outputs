//
//  CardTipViewModel.swift
//  viewModel_inputs_outputs
//
//  Created by mike on 2024/5/7.
//

import UIKit


// 卡片提示 viewModel
class CardTipViewModel: CardTipViewModelType, CardTipViewModelInputs, CardTipViewModelOutputs {
   
    typealias Input = CardTipViewModelInputs
    typealias Output = CardTipViewModelOutputs
    
    weak var inputs: Input? { self }
    weak var outputs: Output? { self }

    var items: [CardTipItem] = []
    
    
    init() {
        // 新增項目
        CardType.allCases.forEach { [weak self] in
            let item = CardTipItem(cardType: $0, count: 0, textColor: .white, backgroundColor: $0.backgroundColor)
            self?.items.append(item)
        }
    }
    
    
    // MARK: Output
    var updateItems: ((NSDiffableDataSourceSnapshot<CardTipCollectionView.SectionType, Item>) -> Void)?
    
    // MARK: Input
    /// 更新卡片提示
    func updateCardTip(_ cardType: CardType, count: Int) {
        
        guard let index = items.firstIndex(where: { $0.cardType == cardType }) else {
            return
        }
        
        // 更新
        items[index].count = count
        
        // 回傳項目
        applySnapshot()
    }
    
    /// 實作結果
    private func applySnapshot() {
        
        var snapshot = NSDiffableDataSourceSnapshot<CardTipCollectionView.SectionType, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main)
        
        updateItems?(snapshot)
    }
}


// MARK: input/output
protocol CardTipViewModelInputs: AnyObject {
    
    /// 更新卡片提示
    func updateCardTip(_ cardType: CardType, count: Int)
}

protocol CardTipViewModelOutputs: AnyObject {
            
    /// 更新項目
    var updateItems: ((NSDiffableDataSourceSnapshot<CardTipCollectionView.SectionType, Item>) -> Void)? { get set }
}

protocol CardTipViewModelType {
    var inputs: CardTipViewModelInputs? { get }
    var outputs: CardTipViewModelOutputs? { get }
}

//MARK:
fileprivate extension CardType {
    
    /// 背景顏色
    var backgroundColor: UIColor {
        
        let alpha = 0.6
        
        switch self {
        case .scissor:
            return .red.withAlphaComponent(alpha)
        case .stone:
            return .green.withAlphaComponent(alpha)
        case .paper:
            return .blue.withAlphaComponent(alpha)
        }
    }
}
