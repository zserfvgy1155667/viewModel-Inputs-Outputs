//
//  CardTipCollectionView.swift
//  viewModel_inputs_outputs
//
//  Created by 林京賢 on 2024/5/5.
//

import UIKit


/// 卡片提示 自訂滾輪清單元件
class CardTipCollectionView: UICollectionView {
    
    typealias cSectionType = CardTipCollectionView.SectionType
    
    
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
            case let (item, cell) as (CardTipItem, CardTipCell):
                cell.setup(item)
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
extension CardTipCollectionView {
    
    /// 區塊
    enum SectionType: Int, CaseIterable {
        
        case main
        
        
        /// 取得 cell id
        var cellId: String {
            String(describing: CardTipCell.self)
        }
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension CardTipCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let count = CGFloat(customDataSource.snapshot().numberOfItems)
        return .init(width: collectionView.frame.width / count, height: collectionView.frame.height)
    }
}
