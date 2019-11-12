//
//  TodoAddViewController.swift
//  ITodo
//
//  Created by velo.yamigiku on 2019/10/04.
//  Copyright © 2019 velo.yamigiku. All rights reserved.
//

import UIKit
import RealmSwift

class TodoAddViewController: UIViewController {
    
    @IBOutlet weak var todoTitle: UITextField!
    @IBOutlet weak var todoContent: InspectableTextView!
    
    var realm: Realm!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        realm = try! Realm()
    }
    
    // 画面表示の直前の処理。
    // 画面初期表示や別の画面に遷移して戻ってきた時に呼び出される。
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        todoContent.togglePlaceholder()
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
                
                // 新規Todoをデータベースに保存する。
                try! realm.write {
                    let todo = Todo()
                    todo.title = todoTitle.text!
                    todo.content = todoContent.text
                    realm.add(todo)
                }
                // 前の画面のビューコントローラを介して、本画面の値を引き継ぐ。
                // Todo一覧変数をデータベース内のTodoで更新する。
                vc.todoList = realm.objects(Todo.self)
                vc.tableView.reloadData()
            }
            // 前の画面に遷移する。
            nc.popViewController(animated: true)
        }
    }
    
    // Todoの内容を編集するボタンをタップした時の処理。
    @IBAction func tapEditTodoContent(_ sender: Any) {
        
        // Todoの内容編集画面のViewControllerを作成する。
        let todoContentViewController = self.storyboard?.instantiateViewController(identifier: "TodoContentViewController") as! TodoContentViewController
        
        todoContentViewController.todoContentTvReadonly = todoContent
        todoContentViewController.todoContent = todoContent.text
        
        // Todoの内容編集画面に遷移する。
        self.navigationController?.pushViewController(todoContentViewController, animated: true)
        
    }
    
}
