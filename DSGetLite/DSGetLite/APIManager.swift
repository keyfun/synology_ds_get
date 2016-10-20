//
//  WebAPI.swift
//  DSGetLite
//
//  Created by Hui Key on 20/10/2016.
//  Copyright © 2016 Key Hui. All rights reserved.
//

import UIKit

class APIManager {
    // APIs
    private let domain = "http://%@"
    private let loginAPI = "/webapi/auth.cgi?api=SYNO.API.Auth&version=2&method=login&account=%@&passwd=%@&session=DownloadStation&format=sid"
    private let logoutAPI = "/webapi/auth.cgi?api=SYNO.API.Auth&version=1&method=logout&session=DownloadStation"
    private let taskInfoAPI = "/webapi/query.cgi?api=SYNO.API.Info&version=1&method=query&query=SYNO.API.Auth,SYNO.DownloadStation.Task"
    private let getDownloadListAPI = "/webapi/DownloadStation/task.cgi?api=SYNO.DownloadStation.Task&version=1&method=list"
    private let createTaskAPI = "/webapi/DownloadStation/task.cgi" // POST
    /*
     api=SYNO.DownloadStation.Task
     &version=1
     &method=create
     &uri=ftps://192.0.0.1:21/test/test.zip
     &username=admin
     &password=123
     */
    
    public var isLogged:Bool = false
    private var sid:String?
    private var address:String = ""
    
    static let sharedInstance : APIManager = {
        let instance = APIManager()
        return instance
    }()
    
    init() {
        
    }
    
    public func login(address:String, account:String, password:String, onComplete:@escaping (_ isLogged:Bool) -> ()) {
        let path = String(format:domain + loginAPI, address, account, password)
        print("path = \(path)")
        
        let url:URL = URL(string: path)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print(error)
                onComplete(false)
                return
            }
            guard let data = data else {
                print("Data is empty")
                onComplete(false)
                return
            }
            
            let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
            print("json = \(json)")
            print("success = \(json["success"] as? Bool)")
            let dataValue = json["data"] as! [String:Any]
            print("sid = \(dataValue["sid"] as? String)")
            self.sid = dataValue["sid"] as? String
            self.address = address
            
            if self.sid != nil {
                self.isLogged = true
            }
            
            onComplete(self.isLogged)
        }
        
        task.resume()
    }
    
    public func getDownloadList(onComplete:@escaping (_ isSuccess:Bool, _ result:TaskListResponse?) -> ()) {
        let path = String(format:domain + getDownloadListAPI, address)
        print("path = \(path)")
        
        let url:URL = URL(string: path)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print(error)
                onComplete(false, nil)
                return
            }
            guard let data = data else {
                print("Data is empty")
                onComplete(false, nil)
                return
            }
            
            let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
            print("json = \(json)")
            let response = TaskListResponse(json: json)
            onComplete(true, response)
        }
        
        task.resume()
    }
}