//
//  UITextField+Extension.swift
//  viewModel_inputs_outputs
//
//  Created by 林京賢 on 2024/5/5.
//

import UIKit

// MARK: - 擴充鍵盤 inputAccessoryView 完成按鈕
extension UITextField {
    
    /// 新增右上角的完成按鈕
    internal func addDoneTooleBar() {
        var itemArray = [UIBarButtonItem]()
        itemArray.append(self.addFlexibleSpaceBtn())
        itemArray.append(self.addDoneButton())
        //toolbar
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.setItems(itemArray, animated: false)
        
        self.inputAccessoryView = toolBar
    }
    
    internal func addDoneButton() -> UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .done,
                               target: self,
                               action: #selector(doneBtnPressed))
    }
    
    internal func addFlexibleSpaceBtn() -> UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                               target: nil,
                               action: nil)
    }
    
    @objc func doneBtnPressed() {
        self.endEditing(true)
    }
}
