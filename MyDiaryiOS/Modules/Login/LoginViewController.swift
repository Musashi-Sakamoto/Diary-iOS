//
//  ViewController.swift
//  MyDiaryiOS
//
//  Created by 坂元 武佐志 on 2019/06/05.
//  Copyright © 2019 musashi. All rights reserved.
//

import Material
import UIKit

class LoginViewController: UIViewController {
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    var presenter: LoginPresenterInterface!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self._setupView()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    private func _setupView() {
        if let toolbar = toolbarController?.toolbar {
            toolbar.title = "Login"
            toolbar.leftViews.forEach { $0.isHidden = true }
        }
    }

    @IBAction func onLoginButtonClicked(_: UIButton) {
        guard let username = userNameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        self.presenter.loginButtonClicked(username: username, password: password)
    }
}

extension LoginViewController: LoginViewInterface {}
