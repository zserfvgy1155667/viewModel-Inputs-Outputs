//
//  ColorTheme.swift
//  viewModel_inputs_outputs
//
//  Created by 林京賢 on 2024/6/16.
//

import UIKit

/// 顏色的基本實作
protocol ColorTheme {
   var black: UIColor { get }
   var white: UIColor { get }
 }

struct LightColorTheme: ColorTheme {
    let black: UIColor = UIColor(hexString: "#FF000000")
    let white: UIColor = UIColor(hexString: "#FFFFFFFF")
}

struct DarkColorTheme: ColorTheme {
    let black: UIColor = UIColor(hexString: "#FF000000")
    let white: UIColor = UIColor(hexString: "#FFFFFFFF")
}
