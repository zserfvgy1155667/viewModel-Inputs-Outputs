//
//  TextButtonCell.swift
//  viewModel_inputs_outputs
//
//  Created by mike on 2024/5/8.
//

import UIKit

/// 文字按鈕
class TextButtonCell: UICollectionViewCell {

    /// 文字元件
    @IBOutlet weak var label: UILabel! {
        didSet {
            label.isUserInteractionEnabled = true
        }
    }
    
    
    // 回傳點擊事件
    var onViewTap: (() -> Void)?
    
    
    // 點擊
    private lazy var labelTap: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTitleTap))
        tap.cancelsTouchesInView = false
        return tap
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 文字點擊
        label.addGestureRecognizer(labelTap)
    }
    
    override func prepareForReuse() {
        
        label.text = ""
        label.textColor = .gray
        label.backgroundColor = .clear
        
        super.prepareForReuse()
    }
    
    /// 安裝
    func setup(_ item: TextButtonItem) {
        
        label.text = item.text
        label.textColor = item.textColor
        label.backgroundColor = item.backgroundColor
    }
    
    @objc func onTitleTap(sender: UITapGestureRecognizer) {
        onViewTap?()
    }
}
