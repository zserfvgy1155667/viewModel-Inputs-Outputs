//
//  Helpers.swift
//  viewModel_inputs_outputs
//
//  Created by 林京賢 on 2024/5/5.
//

import Foundation
import UIKit

public let kScreenWidth: CGFloat = UIScreen.main.bounds.width

public let kScreenHeight: CGFloat = UIScreen.main.bounds.height

public let kScreenBounds: CGRect = UIScreen.main.bounds

public var kStatusBarHeight: CGFloat {
    
    if #available(iOS 13.0, *) {
        return UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? .zero
    }
    else {
        return UIApplication.shared.statusBarFrame.height
    }
}

public var kSafeAreaInsets: UIEdgeInsets {
    
    guard let view = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first else {
        return .init()
    }
    
    if #available(iOS 11.0, *) {
        return view.safeAreaInsets
    } else {
        return .init()
    }
}

public var kTopSafeArea: CGFloat {
    max(kSafeAreaInsets.top, kSafeAreaInsets.left)
}

public var kBottomSafeArea: CGFloat {
    max(kSafeAreaInsets.bottom, kSafeAreaInsets.right)
}
