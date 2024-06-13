//
//  PickerCardCell.swift
//  viewModel_inputs_outputs
//
//  Created by mike on 2024/5/7.
//

import UIKit

/// 選擇卡片 cell
class PickerCardCell: UICollectionViewCell {

    /// 主要 view
    @IBOutlet weak var mainView: UIView! {
        didSet {
            mainView.layer.cornerRadius = 8.0
            mainView.clipsToBounds = true
            
            // border
            mainView.layer.borderWidth = 0.5
            mainView.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    /// 標題文字
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.numberOfLines = 1
            titleLabel.minimumScaleFactor = 0.5
            titleLabel.adjustsFontSizeToFitWidth = true
        }
    }
    
    /// 玩家名字
    @IBOutlet weak var playerLabel: UILabel! {
        didSet {
            playerLabel.numberOfLines = 1
            playerLabel.minimumScaleFactor = 0.5
            playerLabel.adjustsFontSizeToFitWidth = true
        }
    }
    
    
    var onViewTap: (((itemIndex: Int, cardType: CardType)) -> Void)?
    
    
    /// 卡面類型
    private var cardType: CardType?
    /// 目前 cell 索引
    private var itemIndex: Int?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        /// 遮罩點擊
        let tapView = UITapGestureRecognizer(target: self, action: #selector(onViewTap(sender:)))
        mainView.addGestureRecognizer(tapView)
    }
    
    override func prepareForReuse() {
        
        titleLabel.text = ""
        playerLabel.text = ""
    
        mainView.backgroundColor = .clear
        
        cardType = nil
        itemIndex = nil
        
        super.prepareForReuse()
    }
    
    /// 安裝
    func setup(_ item: PickerCardItem, indexPath: IndexPath) {
        
        self.cardType = item.cardType
        self.itemIndex = indexPath.item
        
        
        titleLabel.text = item.titleText
        playerLabel.text = item.playerName ?? ""
        
        titleLabel.textColor = item.titleTextColor
        playerLabel.textColor = item.playerTextColor
        
        mainView.backgroundColor = item.backgroundColor
    }
    
    @objc func onViewTap(sender: UITapGestureRecognizer) {
        
        guard let cardType = cardType,
              let itemIndex = itemIndex,
              playerLabel.text?.isEmpty == true else {
            
            return
        }
        
        onViewTap?((itemIndex: itemIndex, cardType: cardType))
    }
}
