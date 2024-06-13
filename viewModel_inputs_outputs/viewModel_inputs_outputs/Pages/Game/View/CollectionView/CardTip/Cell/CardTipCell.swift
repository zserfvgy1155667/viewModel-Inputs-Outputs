//
//  CardTipCell.swift
//  viewModel_inputs_outputs
//
//  Created by mike on 2024/5/6.
//

import UIKit


/// 卡片提示 cell
class CardTipCell: UICollectionViewCell {

    /// 文字元件
    @IBOutlet weak var label: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        
        label.text = ""
        label.backgroundColor = .clear
        
        super.prepareForReuse()
    }
    
    /// 安裝
    func setup(_ item: CardTipItem) {
        
        label.text = item.text
        label.textColor = item.textColor
        label.backgroundColor = item.backgroundColor
    }
}
