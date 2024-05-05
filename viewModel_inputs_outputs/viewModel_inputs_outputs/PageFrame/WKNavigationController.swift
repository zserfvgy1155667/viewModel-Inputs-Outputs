//
//  WKNavigationController.swift
//  viewModel_inputs_outputs
//
//  Created by 林京賢 on 2024/5/5.
//

import Foundation
import UIKit


/// 導航容器控制器
class WKNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    private let navigationBarColor = UIColor(hexString: "#FF25A6E2")
    
    
    override func viewDidLoad() {
        
        UINavigationBar.appearance().shadowImage = UIImage()
        self.navigationBar.isTranslucent = false
        setupColor()
        
        super.viewDidLoad()
        
        self.delegate = self
    }
    
    ///安裝顏色
    private func setupColor() {
        
        let mainColor = navigationBarColor
        
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = mainColor
            
            appearance.titleTextAttributes = [ NSAttributedString.Key.foregroundColor: UIColor.white ]
            appearance.shadowImage = nil
            appearance.shadowColor = .clear
            navigationBar.standardAppearance = appearance;
            navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
        } else {
            self.navigationBar.barTintColor = mainColor
            self.navigationBar.layer.shadowColor = mainColor.cgColor
        }
        
        self.navigationBar.titleTextAttributes = [ NSAttributedString.Key.foregroundColor: UIColor.white ]
    }
}
