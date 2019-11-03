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

    private var hasLogged = false

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadSettings()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if !APIManager.sharedInstance.isLogged && hasLogged {
            // auto login
            onLogin(sender: nil)
        }
    }

    func loadSettings() {
        txtAddress.text = UserDefaultsUtils.loadAddress()
        txtAccount.text = UserDefaultsUtils.loadAccount()
        txtPassword.text = UserDefaultsUtils.loadPassword()

        if txtAddress.text != "" && txtAccount.text != "" && txtPassword.text != "" {
            hasLogged = true
        }
    }

    @IBAction func onLogin(sender: UIButton?) {
        // auto cache
        UserDefaultsUtils.saveAddress(value: txtAddress.text!)
        UserDefaultsUtils.saveAccount(value: txtAccount.text!)
        UserDefaultsUtils.savePassword(value: txtPassword.text!)

        APIManager.sharedInstance.login(address: txtAddress.text!, account: txtAccount.text!, password: txtPassword.text!) { (isLogged) in
            print("[ViewController] isLogged = \(isLogged)")

            DispatchQueue.main.async {
                self.gotoTaskList()
            }

            // if has create task before logged, create task after logged
            if AppGlobal.sharedInstance.tmpUri != "" {
                APIManager.sharedInstance.createTask(uri: AppGlobal.sharedInstance.tmpUri)
                AppGlobal.sharedInstance.tmpUri = ""
            }
        }
    }

    func gotoTaskList() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "TaskListViewController") as! TaskListViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

