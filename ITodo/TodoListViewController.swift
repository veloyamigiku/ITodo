//
//  TodoListViewController.swift
//  ITodo
//
//  Created by velo.yamigiku on 2019/10/03.
//  Copyright © 2019 velo.yamigiku. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //var todoList = [String]()
    var todoList: Results<Todo>!
    var realm: Realm!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Todo一覧変数を、データベース内のTodoで更新する。
        realm = try! Realm()
        todoList = realm.objects(Todo.self)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
        
        let todo: Todo = todoList[indexPath.row]
        cell.textLabel?.text = todo.title
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Todo編集画面のViewControllerを作成する。
        let todoEditViewController = self.storyboard?.instantiateViewController(identifier: "TodoEditViewController") as! TodoEditViewController
        
        let todo: Todo = todoList[indexPath.row]
        todoEditViewController.todo = todo
        
        // Todo編集画面に遷移する。
        self.navigationController?.pushViewController(todoEditViewController, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            
            // データベースからTodoを削除する。
            try! realm.write {
                realm.delete(todoList[indexPath.row])
            }
            // 内部のTodo一覧を更新する。
            todoList = realm.objects(Todo.self)
            
            // セルを削除する。
            tableView.deleteRows(
                at: [indexPath as IndexPath],
                with: UITableView.RowAnimation.automatic)
            
            tableView.reloadData()
            
        }
    }
}
