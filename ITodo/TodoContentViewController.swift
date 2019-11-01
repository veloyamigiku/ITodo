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
    
    // TextView(Todoの内容)に表示するTodoの内容を保管する変数。
    var todoContent: String = ""
    // 確定したTodoの内容編集の結果を反映するTextViewの参照を保管する。
    var todoContentTvReadonly: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Todoの内容をTextViewに反映する。
        todoContentTv.text = todoContent
        
        // Todoの内容編集を完了するボタンを作成する。
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.done,
            target: self,
            action: #selector(self.tapDone))
        
    }
    
    // Doneボタン(編集確定)をタップした時の処理。
    @objc func tapDone() {
        
        // 編集したTodoの内容を、指定のTextViewに反映する。
        todoContentTvReadonly.text = todoContentTv.text
        
        let nc = self.navigationController
        nc?.popViewController(animated: true)
        
    }

}
