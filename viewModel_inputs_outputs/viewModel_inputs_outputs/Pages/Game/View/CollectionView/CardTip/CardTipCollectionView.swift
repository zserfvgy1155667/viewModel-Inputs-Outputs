//
//  CardTipCollectionView.swift
//  viewModel_inputs_outputs
//
//  Created by 林京賢 on 2024/5/5.
//

import UIKit


/// nft 自訂滾輪清單元件
/// https://medium.com/@le821227/diffable-datasource-for-uitableview-uicollectionview-6c4436362ae6
class CardTipCollectionView: UICollectionView {
    
    typealias cSectionType = CardTipCollectionView.SectionType
    typealias cItem = CardTipCollectionView.Item
    
    
    lazy var customDataSource: UICollectionViewDiffableDataSource<cSectionType, cItem> = {
        .init(collectionView: self, cellProvider: cellProvider)
    }()
    
    lazy var cellProvider: UICollectionViewDiffableDataSource<cSectionType, cItem>.CellProvider = {
        { collectionView, indexPath, itemIdentifier in
            
            let section = SectionType(rawValue: indexPath.section)
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: section?.getCellId(item: itemIdentifier) ?? "",
                for: indexPath
            )
            
            switch section {
            case .main:
                break
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
        
        
//        SectionModel.SectionType.allCases.forEach {
//            register(UINib(nibName: $0.cell, bundle: nil), forCellWithReuseIdentifier: $0.cell)
//        }
        
        delegate = self
    }
}

// MARK: display parameter
extension CardTipCollectionView {
    
    /// 項目
    struct Item: Hashable {
        
        /// 文字
        var text: String
        /// 背景顏色
        var backgroundColor: UIColor
    }
    
    /// 區塊
    enum SectionType: Int {
        case main
        
        
        /// 取得 cell id
        func getCellId(item: Item) -> String {
            
//            switch self {
//            case .navigationBar:
//                return String(describing: NavigationCell.self)
//            case .enter:
//                return String(describing: WKButtonCell.self)
//            case .inputSerial:
//                return String(describing: WKErrorViewCell.self)
//            case .accountTip:
//                return String(describing: AccountHeadStickerCell.self)
//            }
            
            return ""
        }
    }
    
}

// MARK: UICollectionViewDelegateFlowLayout
extension CardTipCollectionView: UICollectionViewDelegateFlowLayout {
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        let section = customDataSource[indexPath.section]
//        let width = collectionView.frame.width
//        
//        switch section.model {
//        case .nft:
//            
//            let cellHeight = cellWidth * (224 / 156)
//            return .init(width: cellWidth, height: cellHeight)
//        case .noNft:
//            return .init(width: width, height: collectionView.frame.height)
//        }
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        
//        let section = customDataSource[section]
//       
//        switch section.model {
//        case .nft:
//
//            return .init(
//                top: cellsPadding + 5,
//                left: leftRightPadding,
//                bottom: cellsPadding + 5,
//                right: leftRightPadding
//            )
//        default:
//            return .zero
//        }
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        
//        let section = customDataSource[section]
//        switch section.model {
//        case .nft:
//            return self.cellsPadding
//        default:
//            return .zero
//        }
//    }
}
