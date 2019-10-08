//
//  TodoListViewController.swift
//  ITodo
//
//  Created by velo.yamigiku on 2019/10/03.
//  Copyright © 2019 velo.yamigiku. All rights reserved.
//

import UIKit

class TodoListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var todoList = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
        
        cell.textLabel?.text = todoList[indexPath.row]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Todo編集画面のViewControllerを作成する。
        let todoEditViewController = self.storyboard?.instantiateViewController(identifier: "TodoEditViewController") as! TodoEditViewController
        todoEditViewController.todoListIdx = indexPath.row
        todoEditViewController.todoTitle = todoList[indexPath.row]
        // Todo編集画面に遷移する。
        self.navigationController?.pushViewController(todoEditViewController, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            // 内部のTodo一覧を更新する。
            todoList.remove(at: indexPath.row)
            // セルを削除する。
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
        }
    }
}
