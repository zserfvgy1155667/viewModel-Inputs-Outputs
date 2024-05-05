//
//  BaseViewController.swift
//  viewModel_inputs_outputs
//
//  Created by 林京賢 on 2024/5/5.
//

import UIKit

/// 頁面基本框架
class BaseViewController: UIViewController {
 
    // back button
    var backBtn = UIButton(type: .custom)
    ///返回按鈕點擊事件
    var onBackButtonTapTrigger: (() -> Void)?
    
    
    /// 鍵盤處理
    internal lazy var keyboardHandler: KeyboardHandler = {
        .init()
    }()
    
    /// 標題字串
    internal var titleText: String? {
        didSet {
            title = titleText
        }
    }
    
    /// 返回按鈕樣式
    internal var backButtonStyle = BackButtonStyle.back
    
    
    init(_ style: InitXibNameStyle = .useClassName) {
        
        switch style {
        case .noUse:
            super.init(nibName: nil, bundle: nil)
        case .useClassName:
            super.init(
                nibName: String(describing: Self.self),
                bundle: nil
            )
        case .custom(let xibName):
            super.init(
                nibName: xibName,
                bundle: nil
            )
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // 狀態列白色文字設定
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        #warning("mike-主題+多語系綁定，有空再補。")
        view.backgroundColor = .white
        
        initUI()
        setupBindings()
    }
    
    /// 初始化介面
    internal func initUI() {
    }
    
    /// 開始綁定
    internal func setupBindings() {
    }
    
    func addBackPresentRootViewController(_ isPopView: Bool = true, style: BaseViewController.BackButtonStyle = .back) {
        
        self.backButtonStyle = style
                
        
        // 安裝返回按鈕
        backBtn.setupBackButton(backButtonStyle)
        backBtn.addTarget(
            self,
            action: #selector(onBackButtonTap),
            for: .touchUpInside
        )
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
        
        // navigationcontroller.pushtViewcontrollers
        if (navigationController?.viewControllers.count ?? 0) > 1 && isPopView {
            onBackButtonTapTrigger = { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @objc private func onBackButtonTap(_ sender: UIButton) {
        backBtn.isEnabled = false
        onBackButtonTapTrigger?()
    }
}

// MARK: extension UIButton
fileprivate extension UIButton {
    
    /// 安裝返回按鈕
    func setupBackButton(_ style: BaseViewController.BackButtonStyle) {
        
        switch style {
        case .back:
            setImage(ImageList.icon_basic_arrow_back_w.toImage(), for: .normal)
            setImage(ImageList.icon_basic_arrow_back_w.toImage(), for: .highlighted)
        }
    }
}

// MARK: display enum
extension BaseViewController {
    
    /// 初始化 xib 類型
    enum InitXibNameStyle {
        
        /// 沒有使用 xib
        case noUse
        
        /// 使用類別名稱
        case useClassName
        
        /// 自訂名稱
        case custom(xibName: String)
    }
    
    /// 返回按鈕樣式
    enum BackButtonStyle {
        
        case back
    }
}
