//
//  SelectCardCollectionView.swift
//  viewModel_inputs_outputs
//
//  Created by mike on 2024/5/7.
//

import UIKit


/// 選擇卡片 自訂滾輪清單元件
class SelectCardCollectionView: UICollectionView {
    
    typealias cSectionType = SelectCardCollectionView.SectionType
    
    /// 行的數量
    let rowCount: CGFloat = 3
    /// 卡片高度
    let cardHeight: CGFloat = 100
    
    /// 點擊事件
    var onCardTap: (((itemIndex: Int, cardType: CardType)) -> Void)?
    
    
    lazy var customDataSource: UICollectionViewDiffableDataSource<cSectionType, Item> = {
        .init(collectionView: self, cellProvider: cellProvider)
    }()
    
    lazy var cellProvider: UICollectionViewDiffableDataSource<cSectionType, Item>.CellProvider = {
        { [weak self] collectionView, indexPath, itemIdentifier in
                    
            let section = self?.customDataSource.snapshot().sectionIdentifier(containingItem: itemIdentifier)
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: section?.cellId ?? "",
                for: indexPath
            )
            
            switch (itemIdentifier, cell) {
            case let (item, cell) as (PickerCardItem, PickerCardCell):
                cell.setup(item, indexPath: indexPath)
                cell.onViewTap = { [weak self] in
                    self?.onCardTap?($0)
                }
            default:
                break
            }
            
            return cell
        }
    }()
    
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        
        // 設定相關數值
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        
        // 設定間距
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionViewLayout = layout
        
        // 註冊 cell
        cSectionType.allCases.forEach {
            register(UINib(nibName: $0.cellId, bundle: nil), forCellWithReuseIdentifier: $0.cellId)
        }
        
        
        delegate = self
    }
}

// MARK: display parameter
extension SelectCardCollectionView {
    
    /// 區塊
    enum SectionType: Int, CaseIterable {
        
        case main
        
        
        /// 取得 cell id
        var cellId: String {
            String(describing: PickerCardCell.self)
        }
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension SelectCardCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width / rowCount, height: cardHeight)
    }
}

