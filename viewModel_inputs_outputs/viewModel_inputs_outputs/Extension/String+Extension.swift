//
//  String+Extension.swift
//  viewModel_inputs_outputs
//
//  Created by 林京賢 on 2024/6/13.
//

import Foundation

extension String {
    
    /// 取代文字使用
    func replace(target: String, withString: String) -> String {
        return self.replacingOccurrences(
            of: target,
            with: withString,
            options: NSString.CompareOptions.literal,
            range: nil
        )
    }
}
