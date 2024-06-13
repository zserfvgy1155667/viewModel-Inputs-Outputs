//
//  BaseCoordinator.swift
//  viewModel_inputs_outputs
//
//  Created by 林京賢 on 2024/5/5.
//

import Foundation
import UIKit


typealias BaseCoordinatorType<RouteType> = BaseCoordinator<RouteType> & BaseCoordinatorProtocol

/// 基本實作
protocol BaseCoordinatorProtocol {
    
    var coordinatorRootVC: UIViewController { get }
    
    var childCoordinators: [UUID : BaseCoordinatorProtocol] { get }
}

/// 頁面基本導入口
class BaseCoordinator<RouteType>: NSObject, UIViewControllerTransitioningDelegate {
    
    /// 緩存的導入口
    var childCoordinators = [UUID : BaseCoordinatorProtocol]()
    /// 最外層回呼
    var onDisposeComplete: ((RouteType) -> Void)?
    
    /// coordinator
    lazy var completeEvent: ((RouteType) -> Void) = {
        { [weak self] type in
            self?.onDispose(type)
            self?.onDisposeComplete?(type)
        }
    }()
    
    
    /// 記錄唯一值
    private let identifier = UUID()


    /// 註冊頁面
    func coordinate<T>(to coordinator: BaseCoordinatorType<T>) {
        
        store(coordinator)
        
        // 設定完成事件
        coordinator.completeEvent = { [weak self, weak coordinator] type in
         
            guard let self = self,
                  let coordinator = coordinator else {
                return
            }
            
            coordinator.onDispose(type)
            coordinator.onDisposeComplete?(type)
            self.free(coordinator)
        }
        
        coordinator.start()
    }
    
    /// 啟動頁面
    func start() {
        fatalError("start method should be implemented")
    }
    
    /// coordinator 已經呼叫完成，告訴繼承的 coordinator 做銷毀動作。
    func onDispose(_ type: RouteType) {
        fatalError("onDispose method should be implemented")
    }
    
    
    private func store<T>(_ coordinator: BaseCoordinatorType<T>) {
        childCoordinators[coordinator.identifier] = coordinator
    }
    
    private func free<T>(_ coordinator: BaseCoordinatorType<T>) {
        childCoordinators[coordinator.identifier] = nil
    }
    
    
    // MARK: - UIViewControllerTransitioningDelegate
    func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        FadeViewControllerTransition(isFadeOut: false)
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        FadeViewControllerTransition(isFadeOut: true)
    }
}
