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
    
    var todo: Todo! = nil
    var realm: Realm!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        realm = try! Realm()
        
        //todoTitleTf.text = todoTitle
        todoTitleTf.text = todo.title
        
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
                }
                // Todo一覧変数をデータベース内のTodoで更新する。
                vc.todoList = realm.objects(Todo.self)
                vc.tableView.reloadData()
            }
            nc.popViewController(animated: true)
        }
    }
}
