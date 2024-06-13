//
//  PickerCardItem.swift
//  viewModel_inputs_outputs
//
//  Created by mike on 2024/5/7.
//

import UIKit


/// 選擇卡片
class PickerCardItem: Item {
    
    override var identifier: String {
        UUID().uuidString
    }
    
    
    var titleText: String {
        isOpenCard ? cardType.text : ""
    }
    
    var titleTextColor: UIColor {
        playerName == nil ? .gray : .white
    }
    
    var playerTextColor: UIColor {
        playerName == nil ? .white : .black
    }
    
    var backgroundColor: UIColor {
        
        if playerName != nil && isOpenCard {
            return .red.withAlphaComponent(0.6)
        }
        else if isOpenCard {
            return .red.withAlphaComponent(0.3)
        }
        return .clear
    }
    
    /// 卡片類型
    var cardType: CardType
    /// 玩家名稱 (有表示已經選擇該卡片)
    var playerName: String?
    /// 是否已經開卡
    var isOpenCard: Bool
    
    
    init(cardType: CardType, isOpenCard: Bool = false, playerName: String? = nil) {
        self.cardType = cardType
        self.isOpenCard = isOpenCard
        self.playerName = playerName
    }
    
    override func hash(into hasher: inout Hasher) {
        hasher.combine(cardType)
        hasher.combine(isOpenCard)
        hasher.combine(playerName)
        super.hash(into: &hasher)
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        let i = toSelfObject(object)
        return super.isEqual(object) &&
        cardType == i?.cardType &&
        isOpenCard == i?.isOpenCard &&
        playerName == i?.playerName
    }
}

