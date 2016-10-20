//
//  TaskListViewController.swift
//  DSGetLite
//
//  Created by Hui Key on 20/10/2016.
//  Copyright © 2016 Key Hui. All rights reserved.
//

import UIKit

class TaskListViewController: UITableViewController {
    
    private var tasks: Array<Task> = Array<Task>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // under status bar
        tableView.contentInset = UIEdgeInsetsMake(20.0, 0.0, 0.0, 0.0)
        
        APIManager.sharedInstance.getDownloadList { (isSuccess:Bool, result:TaskListResponse?) in
            print("isSuccess = \(isSuccess)")
            if result != nil {
                print("response = \(result!.toString())")
                self.tasks = result!.tasks!
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        
        let task:Task = self.tasks[indexPath.row]
        cell.textLabel?.text = task.title + " " + task.status
        
        return cell
    }
}
