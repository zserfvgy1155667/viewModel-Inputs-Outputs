//
//  LoginCoordinator.swift
//  viewModel_inputs_outputs
//
//  Created by 林京賢 on 2024/5/5.
//

import UIKit

/// 登入頁面導入口
class LoginCoordinator: BaseCoordinatorType<BaseCoordinatorResultType> {
    
    var coordinatorRootVC: UIViewController { navi }
    
    var navi: WKNavigationController
    
    private let rootViewController: UIViewController
    
    private var vc: LoginViewController
    
    
    init(rootViewController: UIViewController) {
        
        self.rootViewController = rootViewController
        
        vc = .init(
            minPlayersCount: Utils.minPlayersCount,
            maxPlayersCount: Utils.maxPlayersCount
        )
        navi = WKNavigationController(rootViewController: vc)

        super.init()
        
        navi.modalPresentationStyle = .overFullScreen
        navi.transitioningDelegate = self
        navi.navigationBar.isHidden = true
    }
    
    override func start() {

        vc.viewModel.delegate = self
        
        rootViewController.present(navi, animated: true)
    }
}

// MARK: extension LoginViewModelDelegate
extension LoginCoordinator: LoginViewModelDelegate {
    
    func onLoginSuccess(_ playerNames: [String]) {
        
        let select = GameCoordinator(rootViewController: navi, playerNames: playerNames)
        coordinate(to: select)
    }
}
