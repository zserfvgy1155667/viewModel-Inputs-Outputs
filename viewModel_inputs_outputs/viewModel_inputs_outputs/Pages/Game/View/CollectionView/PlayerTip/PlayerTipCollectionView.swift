//
//  PlayerTipCollectionView.swift
//  viewModel_inputs_outputs
//
//  Created by mike on 2024/5/7.
//

import UIKit


/// 玩家提示 自訂滾輪清單元件
class PlayerTipCollectionView: UICollectionView {
    
    typealias cSectionType = PlayerTipCollectionView.SectionType
    

    /// 文字按鈕點擊事件
    var onTextButtonTap: (() -> Void)?
    
    
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
            case let (item, cell) as (PlayerTipItem, PlayerTipCell):
                cell.setup(item)
            case let (item, cell) as (TextButtonItem, TextButtonCell):
                cell.setup(item)
                cell.onViewTap = { [weak self] in
                    self?.onTextButtonTap?()
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
extension PlayerTipCollectionView {
    
    /// 區塊
    enum SectionType: Int, CaseIterable {
        
        /// 玩家提示
        case playerTip
        /// 文字按鈕
        case textButton
        
        
        /// 取得 cell id
        var cellId: String {
            
            switch self {
            case .playerTip:
                return String(describing: PlayerTipCell.self)
            case .textButton:
                return String(describing: TextButtonCell.self)
            }
        }
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension PlayerTipCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let item = customDataSource.itemIdentifier(for: indexPath)
        
        if item is PlayerTipItem {
            let count = CGFloat(customDataSource.snapshot().numberOfItems)
            return .init(width: collectionView.frame.width / count, height: collectionView.frame.height)
        }
        else if item is TextButtonItem {
            return .init(width: collectionView.frame.width, height: collectionView.frame.height)
        }
        
        return .zero
    }
}


