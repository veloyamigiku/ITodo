//
//  TodoAddViewController.swift
//  ITodo
//
//  Created by velo.yamigiku on 2019/10/04.
//  Copyright © 2019 velo.yamigiku. All rights reserved.
//

import UIKit

class TodoAddViewController: UIViewController {
    
    @IBOutlet weak var todoTitle: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tapDone(_ sender: Any) {
        if self.navigationController != nil {
            // ナビゲーションコントローラを参照する。
            let nc = self.navigationController!
            // ナビゲーションコントローラ上のビューコントローラのスタックのサイズを取得する。
            // スタックは、
            // 次の画面に遷移するとスタックの末尾にビューコントローラの参照を追加する。
            // 前の画面に遷移するとスタックの末尾からビューコントーラを除去する。
            let count = nc.viewControllers.count
            if nc.viewControllers[count - 2] is TodoListViewController {
                // ビューコントローラのスタックの最後から１つ前のビューコントローラを参照する。
                let vc = nc.viewControllers[count - 1 - 1] as! TodoListViewController
                // 前の画面のビューコントローラを介して、本画面の値を引き継ぐ。
                vc.todoList.append(todoTitle.text!)
                vc.tableView.reloadData()
            }
            // 前の画面に遷移する。
            nc.popViewController(animated: true)
        }
    }
}
