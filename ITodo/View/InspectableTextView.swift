//
//  InspectableTextView.swift
//  ITodo
//
//  Created by velo.yamigiku on 2019/11/12.
//  Copyright © 2019 velo.yamigiku. All rights reserved.
//

import UIKit

// IBDesignableは、IBInspectableのプロパティの変更をリアルタイムにStoryboardに反映する。
@IBDesignable class InspectableTextView: UITextView {
    
    // IBInspectableは、指定のプロパティをStoryboardで変更できるようにする。
    // 本プログラムでは、本Viewロード時に作成するラベルのテキストなので、Storyboard（アプリケーション実行前）では確認できない。
    @IBInspectable var placeholderString: String = "" {
        didSet {
            guard !placeholderString.isEmpty else { return }
            placeholderLabel.text = placeholderString
            placeholderLabel.sizeToFit()
        }
    }
    
    // プレースホルダー用のラベル。
    // lazyにより、指定のプロパティが初めて参照された時、右辺が評価される。
    private lazy var placeholderLabel = UILabel(frame: CGRect(x: 6, y: 6, width: 0, height: 0))
    
    // 本Viewロード時の処理。
    override func awakeFromNib() {
        super.awakeFromNib()
        delegate = self
        configurePlaceholder()
    }
    
    // プレースホルダーを設定する。
    private func configurePlaceholder() {
        // プレースホルダーの文字色を設定する。
        placeholderLabel.textColor = UIColor.gray
        // TextViewにプレースホルダーを配置する。
        addSubview(placeholderLabel)
    }
    
    public func togglePlaceholder() {
        // TextViewに入力がない場合はプレースホルダーを表示する。そうでない場合は非表示とする。
        placeholderLabel.isHidden = text.isEmpty ? false : true
    }
}

extension InspectableTextView: UITextViewDelegate {
    
    // TextViewへの入力が完了した時の処理。
    func textViewDidChange(_ textView: UITextView) {
        togglePlaceholder()
    }
    
}
