//
//  CardTipItem.swift
//  viewModel_inputs_outputs
//
//  Created by mike on 2024/5/6.
//

import UIKit


/// 卡片提示
class CardTipItem: Item {
    
    override var identifier: String {
        text
    }
    
    var text: String {
        "\(cardType.text)×\(count)"
    }
    
    /// 卡片類型
    var cardType: CardType
    /// 數量
    var count: Int
    /// 文字顏色
    var textColor: UIColor
    /// 背景顏色
    var backgroundColor: UIColor
    
    
    init(cardType: CardType, count: Int, textColor: UIColor, backgroundColor: UIColor) {
        self.cardType = cardType
        self.count = count
        self.textColor = textColor
        self.backgroundColor = backgroundColor
    }
    
    override func hash(into hasher: inout Hasher) {
        hasher.combine(text)
        hasher.combine(textColor)
        hasher.combine(backgroundColor)
        super.hash(into: &hasher)
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        let i = toSelfObject(object)
        return super.isEqual(object) &&
        text == i?.text &&
        textColor == i?.textColor &&
        backgroundColor == i?.backgroundColor
    }
}
