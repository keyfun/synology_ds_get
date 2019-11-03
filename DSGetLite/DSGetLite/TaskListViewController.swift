//
//  TaskListViewController.swift
//  DSGetLite
//
//  Created by Hui Key on 20/10/2016.
//  Copyright © 2016 Key Hui. All rights reserved.
//

import UIKit

class TaskListViewController: UITableViewController {

    private var tasks = Array<Task>()
    private var timer: Timer? = nil
    private var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        textField = UITextField.init(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        textField.text = ""
        textField.placeholder = "Input url"
        textField.textAlignment = .center
        self.navigationItem.titleView = textField

        let btnAdd = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(self.onTapAdd))
        self.navigationItem.rightBarButtonItem = btnAdd

        // call update list
        refreshList()
    }

    @objc private func onTapAdd() {
        print("onTapAdd: \(String(describing: textField.text))")
        if let uri = textField.text, !uri.isEmpty {
            APIManager.sharedInstance.createTask(uri: uri)
            UIPasteboard.general.string = ""
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // auto refresh, start timer
        timer = Timer.scheduledTimer(timeInterval: 5,
            target: self,
            selector: #selector(self.refreshList),
            userInfo: nil,
            repeats: true)

        // auto paste clipboard to input field
        textField.text = UIPasteboard.general.string
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
