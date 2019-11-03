//
//  DownloadTaskResponse.swift
//  DSGetLite
//
//  Created by Hui Key on 20/10/2016.
//  Copyright © 2016 Key Hui. All rights reserved.
//

class TaskListResponse {

    var offset: Int = 0
    var tasks: Array<Task>? = nil
    var total: Int = 0
    var success: Int = 0

    init(json: [String: Any]) {

        success = json["success"] as! Int

        guard let data = json["data"] as? [String: Any] else {
            return
        }

        offset = data["offset"] as! Int
        total = data["total"] as! Int

        tasks = Array<Task>()
        guard let tasksArray: [AnyObject] = data["tasks"] as? [AnyObject] else {
            return
        }

        for taskJson in tasksArray {
            let task: Task = Task(json: taskJson as! [String: Any])
            tasks!.append(task)
        }
    }

    func toString() -> String {
        var str: String = "offset = \(offset) \n"
        str += "total = \(total) \n"
        str += "success = \(success) \n"
        if tasks != nil {
            str += "tasks count = \(tasks!.count) \n"
            for task in tasks! {
                str += "task = \(task.toString()) \n"
            }
        }
        return str
    }
}
