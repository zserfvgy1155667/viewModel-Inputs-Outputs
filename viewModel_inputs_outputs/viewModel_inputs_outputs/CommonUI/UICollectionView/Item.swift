//
//  Item.swift
//  viewModel_inputs_outputs
//
//  Created by mike on 2024/5/6.
//

import Foundation


/// 基本 item 框架
class Item: Hashable {
    
    /// 分別 item 是否為唯一值
    var identifier: String {
        ""
    }
    
    /// 組 hash 值用
    public func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    /// 子類別需要復寫此方法。
    /// 不然默認為 identity 與 isPlaceholder 判斷。
    internal func isEqual(_ object: Any?) -> Bool {
        let i = toSelfObject(object)
        return identifier == i?.identifier
    }

    /// 轉換成自己
    internal func toSelfObject(_ object: Any?) -> Self? {
        guard object != nil && type(of: object!) == Self.self else {
            return nil
        }
        return object as? Self
    }
    
    /// 不需要復寫
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.isEqual(rhs)
    }
}
