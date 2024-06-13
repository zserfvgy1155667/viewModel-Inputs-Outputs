//
//  AppCoordinator.swift
//  viewModel_inputs_outputs
//
//  Created by 林京賢 on 2024/5/5.
//

import Foundation
import UIKit


/// app 主進入點
class AppCoordinator: BaseCoordinatorType<Void> {
    
    var coordinatorRootVC: UIViewController { navi }
    
    var navi: WKNavigationController = {
        let vc = UIViewController()
        let navi = WKNavigationController(rootViewController: vc)
        navi.navigationBar.isHidden = true
        return navi
    }()
    
    private let window: UIWindow
    
    
    init(window: UIWindow) {
        self.window = window
    }

    override func start() {
        
        window.rootViewController = navi
        window.makeKeyAndVisible()
    
        initTheme()
        route()
    }
    
    override func onDispose(_ type: Void) {
        navi.dismiss(animated: false)
    }
    
    private func initTheme() {
        #warning("mike-設定顏色與主題")
    }
    
    /// 切換登入或遊戲主頁
    func route(isInGame: Bool = false) {
        if isInGame {
            #warning("mike-本地緩存，待補。")
        }
        else {
            let login = LoginCoordinator(rootViewController: coordinatorRootVC)
            coordinate(to: login)
            login.onDisposeComplete = { [weak self] _ in
                self?.completeEvent(())
            }
        }
    }
}

