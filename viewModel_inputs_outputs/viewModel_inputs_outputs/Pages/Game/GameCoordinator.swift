//
//  GameCoordinator.swift
//  viewModel_inputs_outputs
//
//  Created by 林京賢 on 2024/5/5.
//

import UIKit

/// 登入頁面導入口
class GameCoordinator: BaseCoordinatorType<BaseCoordinatorResultType> {
    
    var coordinatorRootVC: UIViewController { navi }
    
    var navi: WKNavigationController
    
    private let rootViewController: UIViewController
    
    private var vc: GameViewController
    
    
    init(rootViewController: UIViewController, playerNames: [String]) {
        self.rootViewController = rootViewController
        vc = .init(playerNames: playerNames)
        
        navi = WKNavigationController(rootViewController: vc)
        navi.navigationBar.isHidden = false
        navi.modalPresentationStyle = .overFullScreen
        
        super.init()
    }
    
    deinit {
        print("deiniting \(self)")
    }
    
    override func start() {

        navi.transitioningDelegate = self
        
        rootViewController.present(navi, animated: true)
            
        vc.backBtn.addTarget(
            self,
            action: #selector(onBackButtonTap),
            for: .touchUpInside
        )
    }
    
    @objc private func onBackButtonTap() {
        vc.backBtn.isEnabled = false
        completeEvent(.none)  // 不返回參數，也可以用 viewModel delegate 實踐。
    }
    
    override func onDispose(_ type: BaseCoordinatorResultType) {
        navi.dismiss(animated: false)
    }
}


