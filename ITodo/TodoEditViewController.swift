//
//  TodoEditViewController.swift
//  ITodo
//
//  Created by velo.yamigiku on 2019/10/08.
//  Copyright © 2019 velo.yamigiku. All rights reserved.
//

import UIKit

class TodoEditViewController: UIViewController {
    
    @IBOutlet weak var todoTitleTf: UITextField!
    
    var todoListIdx: Int? = nil
    var todoTitle: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoTitleTf.text = todoTitle
        
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
                vc.todoList[todoListIdx!] = todoTitleTf.text!
                vc.tableView.reloadData()
            }
            nc.popViewController(animated: true)
        }
    }
}
