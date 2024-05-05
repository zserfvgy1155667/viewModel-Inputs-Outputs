//
//  String+Common.swift
//  viewModel_inputs_outputs
//
//  Created by 林京賢 on 2024/5/5.
//

import UIKit


extension String {
    
    /// 將字串轉圖片
    func toImage() -> UIImage? {
        UIImage(named: self, in: nil, compatibleWith: nil)
    }
}
