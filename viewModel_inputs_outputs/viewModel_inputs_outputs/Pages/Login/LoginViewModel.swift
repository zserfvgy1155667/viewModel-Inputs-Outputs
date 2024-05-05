//
//  LoginViewModel.swift
//  viewModel_inputs_outputs
//
//  Created by 林京賢 on 2024/5/5.
//

/// viewModel 委派
protocol LoginViewModelDelegate: AnyObject {

    func onLoginSuccess(_ playerNames: [String])
}


// viewModel
class LoginViewModel: LoginViewModelType, LoginViewModelInputs, LoginViewModelOutputs {
   
    typealias Input = LoginViewModelInputs
    typealias Output = LoginViewModelOutputs

    
    weak var delegate: LoginViewModelDelegate?
    
    weak var inputs: Input? { self }
    weak var outputs: Output? { self }
    
    
    // MARK: Output
    var focusInput: (() -> Void)?
    var updateInputText: ((String) -> Void)?
    
    /// 最小玩家數量 (有空可以改成建構子傳值)
    let minPlayersCount: Int = 2
    /// 最大玩家數量 (有空可以改成建構子傳值)
    let maxPlayersCount: Int = 20
    /// 目前玩家數量
    private var playersCount: Int = 0
    
    
    // MARK: Input
    /// 顯示頁面結束
    func viewDidAppearTrigger(textFieldCount: Int) {
        
        if textFieldCount == 0 {
            focusInput?()
        }
    }
    
    /// 文字變化
    func inputTextChanged(text: String) {
        let numbers = Int(text)
        
        if var numbers = numbers {
            
            // 超過最大玩家，調整成最大值。
            if numbers > maxPlayersCount {
                numbers = maxPlayersCount
            }
            
            self.playersCount = numbers
            
            
            //MARK: 更新外部結果。
            // 假如是 0，強制清空。
            if numbers == 0 {
                updateInputText?("")
                return
            }
            
            //更新數量
            updateInputText?(String(numbers))
        }
    }
    
    /// 登入按鈕點擊
    func loginButtonClick() {
        
        if playersCount >= minPlayersCount {
            let result = (0..<playersCount).map{"player_\($0 + 1)"}
            delegate?.onLoginSuccess(result)
        }
    }
}


// MARK: input/output
protocol LoginViewModelInputs: AnyObject {
        
    /// 顯示頁面結束
    func viewDidAppearTrigger(textFieldCount: Int)
    /// 文字變化
    func inputTextChanged(text: String)
    /// 登入按鈕點擊
    func loginButtonClick()
}

protocol LoginViewModelOutputs: AnyObject {
        
    /// 取得輸入焦點
    var focusInput: (() -> Void)? { get set }
    /// 更新輸入文字
    var updateInputText: ((String) -> Void)? { get set }
}

protocol LoginViewModelType {
    var inputs: LoginViewModelInputs? { get }
    var outputs: LoginViewModelOutputs? { get }
}


