//
//  FadeViewControllerTransition.swift
//  viewModel_inputs_outputs
//
//  Created by 林京賢 on 2024/5/5.
//

import Foundation
import UIKit

/// 漸進透明動畫
class FadeViewControllerTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    let isFadeOut: Bool
    
    
    init(isFadeOut: Bool) {
        self.isFadeOut = isFadeOut
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        #warning("mike-這邊先不定義變數，後續優化。")
        return 0.15
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        if isFadeOut {
            animateFadeOut(using: transitionContext)
            return
        }
        
        // 頁面透明度 0 -> 1
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        transitionContext.containerView.addSubview(toViewController.view)
        toViewController.view.alpha = 0.0
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            toViewController.view.alpha = 1.0
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    func animateFadeOut(using transitionContext: UIViewControllerContextTransitioning) {
            
        guard let toVC = transitionContext.viewController(forKey: .to),
              let toView = toVC.view,
              let fromVC = transitionContext.viewController(forKey: .from),
              let fromView = fromVC.view
        else {
            
            transitionContext.completeTransition(false)
            return
        }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(fromView)
        fromView.frame.origin = .zero
        
        // 頁面透明度 1 -> 0
        toView.alpha = 1
        fromView.alpha = 1
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            fromView.alpha = 0
        }, completion: { _ in
            
            fromView.removeFromSuperview()
            toVC.view.layoutIfNeeded()
            
            transitionContext.completeTransition(true)
        })
    }
}
