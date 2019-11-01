//
//  TodoEditViewController.swift
//  ITodo
//
//  Created by velo.yamigiku on 2019/10/08.
//  Copyright © 2019 velo.yamigiku. All rights reserved.
//

import UIKit
import RealmSwift

class TodoEditViewController: UIViewController {
    
    @IBOutlet weak var todoTitleTf: UITextField!
    @IBOutlet weak var todoContentTv: UITextView!
    
    var todo: Todo! = nil
    var realm: Realm!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        realm = try! Realm()
        
        todoTitleTf.text = todo.title
        todoContentTv.text = todo.content
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.done,
            target: self,
            action: #selector(self.tapDone))
    }
    
    @objc func tapDone() {
        if self.navigationController != nil {
            let nc = self.navigationController!
            let count = nc.viewControllers.count
            if nc.viewControllers[count - 1 - 1] is TodoListViewController {
                let vc = nc.viewControllers[count - 1 - 1] as! TodoListViewController
                
                // データベースの既存Todoを更新する。
                try! realm.write {
                    todo.title = todoTitleTf.text!
                    todo.content = todoContentTv.text
                }
                // Todo一覧変数をデータベース内のTodoで更新する。
                vc.todoList = realm.objects(Todo.self)
                vc.tableView.reloadData()
            }
            nc.popViewController(animated: true)
        }
    }
    
    // Todoの内容変更ボタンをタップした時の処理。
    @IBAction func tapEditTodoContent(_ sender: Any) {
        // Todoの内容編集画面のViewControllerを作成する。
        let todoContentViewController = self.storyboard?.instantiateViewController(identifier: "TodoContentViewController") as! TodoContentViewController
        
        todoContentViewController.todoContentTvReadonly = todoContentTv
        todoContentViewController.todoContent = todoContentTv.text
        
        // Todoの内容編集画面に遷移する。
        self.navigationController?.pushViewController(todoContentViewController, animated: true)
        
    }
    
}
