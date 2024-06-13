//
//  PlayerTipCell.swift
//  viewModel_inputs_outputs
//
//  Created by mike on 2024/5/7.
//

import UIKit

/// 玩家提示 cell
class PlayerTipCell: UICollectionViewCell {

    /// 主 view
    @IBOutlet weak var mainView: UIView!
    
    /// 玩家名稱文字元件
    @IBOutlet weak var playerNameLabel: UILabel! {
        didSet {
            playerNameLabel.textColor = .black
            playerNameLabel.numberOfLines = 1
            playerNameLabel.minimumScaleFactor = 0.5
            playerNameLabel.adjustsFontSizeToFitWidth = true
        }
    }
    
    /// 顯示生命值
    @IBOutlet weak var raceLabel: UILabel! {
        didSet {
            raceLabel.textColor = .gray
            raceLabel.numberOfLines = 1
            raceLabel.minimumScaleFactor = 0.5
            raceLabel.adjustsFontSizeToFitWidth = true
        }
    }
    
    
    override func prepareForReuse() {
        
        playerNameLabel.text = ""
        raceLabel.text = ""
        
        playerNameLabel.textColor = .black
        raceLabel.textColor = .gray
        
        mainView.backgroundColor = .clear
        
        super.prepareForReuse()
    }
    
    /// 安裝
    func setup(_ item: PlayerTipItem) {
        
        playerNameLabel.text = item.playerName
        playerNameLabel.textColor = item.playerTextColor
        
        raceLabel.text = item.raceCountText
        raceLabel.textColor = item.raceCountTextColor
        
        mainView.backgroundColor = item.backgroundColor
    }
}
