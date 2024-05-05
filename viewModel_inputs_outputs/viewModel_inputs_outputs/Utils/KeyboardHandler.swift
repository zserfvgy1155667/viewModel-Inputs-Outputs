//
//  KeyboardHandler.swift
//  viewModel_inputs_outputs
//
//  Created by 林京賢 on 2024/5/5.
//

import Foundation
import UIKit

/// 鍵盤處理
class KeyboardHandler {
    
    
    /// 正在焦點的輸入框
    weak var textField: UITextField?
    /// uiViewController
    weak var viewController: UIViewController?
    
    
    /// 鍵盤高度
    var keyboardHeight: CGFloat = 0
    
    
    /// 處理類型
    private var type: HandlerType = .normal
    /// CollectionView 原本的目錄位移
    private var srcContentOffset: CGPoint = .zero
    
    
    private lazy var viewTap: UITapGestureRecognizer = {
        let result = UITapGestureRecognizer(target: self, action: #selector(onViewTap))
        result.cancelsTouchesInView = false
        return result
    }()
    
    private lazy var navigationBarTap: UITapGestureRecognizer = {
        let result = UITapGestureRecognizer(target: self, action: #selector(onViewTap))
        result.cancelsTouchesInView = false
        return result
    }()
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    /// 安裝
    func setup(type: HandlerType) {
        self.type = type
        
        // 防呆
        NotificationCenter.default.removeObserver(self)
        
        // 註冊
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onKeyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onKeyboardWillHide),
            name: UIResponder.keyboardWillHideNotification, object: nil
        )
    }
    
    /// 點擊其他 view，強制關閉其他編輯輸入。
    func setupTapViewToEditingEnd() {
        
        guard let viewController = self.viewController else {
            return
        }
        
        // 移除舊有註冊
        viewController.view.removeGestureRecognizer(viewTap)
        viewController.navigationController?.navigationBar.removeGestureRecognizer(navigationBarTap)
        
        // 點擊關閉鍵盤
        viewController.view.addGestureRecognizer(viewTap)
        viewController.navigationController?.navigationBar.addGestureRecognizer(navigationBarTap)
    }
    
    @objc func onViewTap(sender: UITapGestureRecognizer) {
        if textField?.isEditing == true {
            textField?.endEditing(true)
        }
    }
    
    @objc func onKeyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if keyboardHeight != keyboardSize.height {
                self.keyboardHeight = keyboardSize.height
                onKeyboardHeightChanged(self.keyboardHeight)
            }
        }
    }
    
    @objc func onKeyboardWillHide(notification: NSNotification) {
        if keyboardHeight != 0 {
            self.keyboardHeight = 0
            onKeyboardHeightChanged(self.keyboardHeight)
        }
    }
    
    /// 複寫用
    internal func onKeyboardHeightChanged(_ height: CGFloat) {
        
        switch type {
        case .normal:
            
            guard let view = self.viewController?.view,
                  let textField = self.textField else {
                return
            }
            
            /// 鍵盤顯示
            if height > 0 {
                
                //鍵盤頂部 Y軸的位置
                let keyboardY = view.frame.height - height
                //編輯框底部 Y軸的位置
                let editingTextFieldY = textField.convert(textField.bounds, to: view).maxY
                //相減得知, 編輯框有無被鍵盤擋住, > 0 有擋住, < 0 沒擋住, 即是擋住多少
                let targetY = editingTextFieldY - keyboardY
                
                //設置想要多移動的高度
                let offsetY: CGFloat = textField.frame.height
                
                if view.frame.minY >= 0 && targetY > 0 {
                    UIView.animate(withDuration: 0.25, animations: { [weak view] in
                        guard let view = view else {
                            return
                        }
                        view.frame = CGRect(
                            x: 0,
                            y:  -targetY - offsetY,
                            width: view.bounds.width,
                            height: view.bounds.height
                        )
                    })
                }
            }
            else {
                UIView.animate(withDuration: 0.25, animations: { [weak view] in
                    guard let view = view else {
                        return
                    }
                    view.frame = CGRect(
                        x: 0,
                        y: 0,
                        width: view.bounds.width,
                        height: view.bounds.height
                    )
                })
            }
        }
    }
}

/// display enum
extension KeyboardHandler {
    
    /// 處理類型
    enum HandlerType {
        
        case normal
    }
}
