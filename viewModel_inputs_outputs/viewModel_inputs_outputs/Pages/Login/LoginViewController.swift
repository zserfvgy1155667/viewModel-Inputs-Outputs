//
//  LoginViewController.swift
//  viewModel_inputs_outputs
//
//  Created by 林京賢 on 2024/5/5.
//

import UIKit

/// 登入頁面-顯示要輸入幾人遊玩
class LoginViewController: BaseViewController {

    /// 標題
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = "welcome!" // 可以實作在 viewModel type protocal，先這樣處裡。
            titleLabel.font = .systemFont(ofSize: 26)
        }
    }
    /// 輸入框
    @IBOutlet weak var textField: UITextField! {
        didSet {
            
            // 可以實作在 viewModel outputs
            let placeholder = "人數 (上限: \(viewModel.maxPlayersCount))"
            textField.attributedPlaceholder = NSAttributedString(
                string: placeholder,
                attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray]
            )
            
            textField.borderStyle = .roundedRect
            textField.textColor = .gray
            textField.layer.borderWidth = 0.5
            textField.layer.borderColor = UIColor.lightGray.cgColor
            
            textField.addDoneTooleBar()
        }
    }
    /// 登入按鈕
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            loginButton.setTitle("Go", for: .normal) // 可以實作在 viewModel outputs
        }
    }
    
    
    let viewModel: LoginViewModel
    
    
    /// 建構子
    /// - Parameters:
    ///   - minPlayersCount: 最小玩家數量
    ///   - maxPlayersCount: 最大玩家數量
    init(minPlayersCount: Int, maxPlayersCount: Int) {
        viewModel = .init(
            minPlayersCount: minPlayersCount,
            maxPlayersCount: maxPlayersCount
        )
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.inputs?.viewDidAppearTrigger(textFieldCount: textField.text?.count ?? 0)
    }

    /// 初始化介面
    override func initUI() {
        
        // 安裝鍵盤處理事件
        keyboardHandler.textField = textField
        keyboardHandler.viewController = self
        keyboardHandler.setup(type: .normal)
        keyboardHandler.setupTapViewToEditingEnd()
        
        // 安裝文字監聽
        textField.addTarget(self, action: #selector(onTextFieldDidChange(_:)), for: .editingChanged)
        
        // 按鈕按下後的動作
        loginButton.addTarget(
            self,
            action: #selector(onLoginButtonClick(_:)),
            for: .touchUpInside
        )
    }
    
    /// 開始綁定
    override func setupBindings() {
        
        // 事件監聽
        viewModel.outputs?.focusInput = { [weak self] in
            self?.textField.becomeFirstResponder()
        }
        viewModel.outputs?.updateInputText = { [weak self] in
            if self?.textField.text != $0 {
                self?.textField.text = $0
            }
        }
    }
    
    @objc func onTextFieldDidChange(_ textField: UITextField) {
        viewModel.inputs?.inputTextChanged(text: textField.text ?? .init())
    }
    
    @objc func onLoginButtonClick(_ button: UIButton) {
        viewModel.inputs?.loginButtonClick()
    }
}
