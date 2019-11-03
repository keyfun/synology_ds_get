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
    private var timer: Timer? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // under status bar
        tableView.contentInset = UIEdgeInsetsMake(20.0, 0.0, 0.0, 0.0)

        // call update list
        refreshList()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // auto refresh, start timer
        timer = Timer.scheduledTimer(timeInterval: 5,
            target: self,
            selector: #selector(self.refreshList),
            userInfo: nil,
            repeats: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
        timer = nil
    }

    @objc func refreshList() {
        APIManager.sharedInstance.getDownloadList { (isSuccess: Bool, result: TaskListResponse?) in
            print("isSuccess = \(isSuccess)")
            if result != nil {
                print("response = \(result!.toString())")
                self.tasks = result!.tasks!

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)

        let task: Task = self.tasks[indexPath.row]
        cell.textLabel?.text = task.title
        cell.detailTextLabel?.text = task.status

        return cell
    }
}
