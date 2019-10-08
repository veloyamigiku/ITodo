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
}
