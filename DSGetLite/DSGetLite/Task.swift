//
//  Task.swift
//  DSGetLite
//
//  Created by Hui Key on 20/10/2016.
//  Copyright © 2016 Key Hui. All rights reserved.
//

import Foundation

class Task {

    var id: String
    var size: Int64
    var status: String
    var title: String
    var type: String
    var username: String

    init(json: [String: Any]) {
        id = json["id"] as! String
        size = (json["size"] as! NSNumber).int64Value
        status = json["status"] as! String
        title = json["title"] as! String
        type = json["type"] as! String
        username = json["username"] as! String
    }

    func toString() -> String {
        var str: String = "id = \(id), "
        str += "size = \(size), "
        str += "status = \(status), "
        str += "title = \(title), "
        str += "type = \(type), "
        str += "username = \(username)"
        return str
    }

}
