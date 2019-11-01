//
//  TodoContentViewController.swift
//  ITodo
//
//  Created by xda-yoshioka on 2019/11/01.
//  Copyright © 2019 velo.yamigiku. All rights reserved.
//

import UIKit

class TodoContentViewController: UIViewController {
    
    @IBOutlet weak var todoContentTv: UITextView!
    @IBOutlet weak var todoContentTvMarginBottom: NSLayoutConstraint!
    
    // TextView(Todoの内容)に表示するTodoの内容を保管する変数。
    var todoContent: String = ""
    // 確定したTodoの内容編集の結果を反映するTextViewの参照を保管する。
    var todoContentTvReadonly: UITextView!
    // TextView(Todoの内容)のマージンを参照する変数。
    var todoContentTvMarginBottomDefault: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Todoの内容をTextViewに反映する。
        todoContentTv.text = todoContent
        
        // Todoの内容編集を完了するボタンを作成する。
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.done,
            target: self,
            action: #selector(self.tapDone))
        
        todoContentTvMarginBottomDefault = todoContentTvMarginBottom.constant
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObserver()
    }
    
    func configureObserver() {
        
        // オブザーバ（キーボート表示）を追加する。
        let notification = NotificationCenter.default
        notification.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
    }
    
    func removeObserver() {
        
        // オブザーバを破棄する。
        let notification = NotificationCenter.default
        notification.removeObserver(self)
        
    }
    
    // キーボード表示の際に実行する処理。
    @objc func keyboardWillShow(notification: Notification) {
        
        let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        let keyboardShowDuration: TimeInterval = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double)!
        
        UIView.animate(
            withDuration: keyboardShowDuration,
            animations: { () in
                // TextView(Todoの内容)の底のマージンに、キーボードの高さを追加する。
                self.todoContentTvMarginBottom.constant = keyboardRect!.height + self.todoContentTvMarginBottomDefault
        })
    }
    
    /*
    @objc func keyboardWillHide(notification: Notification) {
        
        let keyboardHideDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double)!
        
        UIView.animate(
            withDuration: keyboardHideDuration,
            animations: { () in
                self.todoContentTvMarginBottom.constant = self.todoContentTvMarginBottomDefault
        })
    }
    */
    
    // Doneボタン(編集確定)をタップした時の処理。
    @objc func tapDone() {
        
        // 編集したTodoの内容を、指定のTextViewに反映する。
        todoContentTvReadonly.text = todoContentTv.text
        
        let nc = self.navigationController
        nc?.popViewController(animated: true)
        
    }

}
