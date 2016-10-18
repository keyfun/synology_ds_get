//
//  ViewController.swift
//  DSGetLite
//
//  Created by Hui Key on 18/10/2016.
//  Copyright © 2016 Key Hui. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtAccount: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadSettings()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func loadSettings() {
        txtAddress.text = UserDefaultsUtils.loadAddress()
        txtAccount.text = UserDefaultsUtils.loadAccount()
        txtPassword.text = UserDefaultsUtils.loadPassword()
    }
    
    @IBAction func onLogin(sender: UIButton) {
        login(address: txtAddress.text!, account: txtAccount.text!, password: txtPassword.text!)
        
        // auto cache
        UserDefaultsUtils.saveAddress(value: txtAddress.text!)
        UserDefaultsUtils.saveAccount(value: txtAccount.text!)
        UserDefaultsUtils.savePassword(value: txtPassword.text!)
    }

    func login(address:String, account:String, password:String) {
        let loginAPI = "http://%@/webapi/auth.cgi?api=SYNO.API.Auth&version=2&method=login&account=%@&passwd=%@&session=DownloadStation&format=sid"
        let path = String(format:loginAPI, address, account, password)
        print("path = \(path)")
        
        let url:URL = URL(string: path)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print(error)
                return
            }
            guard let data = data else {
                print("Data is empty")
                return
            }
            
//            print("data = \(data)")
//            print("response = \(response)")
            
            let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
            print("json = \(json)")
            print("success = \(json["success"] as? Bool)")
            let dataValue = json["data"] as! [String:Any]
            print("sid = \(dataValue["sid"] as? String)")
        }
        
        task.resume()
    }
    
    func logout() {
        
    }

}

