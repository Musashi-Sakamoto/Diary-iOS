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
    @IBOutlet var emailTextField: TextField!
    @IBOutlet var userNameTextField: TextField!
    @IBOutlet var passwordTextField: TextField!
    var presenter: LoginPresenterInterface!

    @IBOutlet var toLoginButton: RaisedButton!
    @IBOutlet var loginButton: RaisedButton!
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
            self.emailTextField.isHidden = true
            toolbar.leftViews.forEach { $0.isHidden = true }
        }
    }

    @IBAction func onLoginButtonClicked(_: UIButton) {
        guard let username = userNameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        if self.presenter.isLogin() {
            self.presenter.loginButtonClicked(username: username, password: password)
        } else {
            guard let email = emailTextField.text else { return }
            self.presenter.signupButtonClicked(email: email, username: username, password: password)
        }
    }

    @IBAction func onToLoginButtonClicked(_ sender: RaisedButton) {
        self.presenter.toLoginButtonClicked()
    }
}

extension LoginViewController: LoginViewInterface {
    func showSignup() {
        if let toolbar = toolbarController?.toolbar {
            toolbar.title = "Signup"
        }
        self.loginButton.setTitle("Signup", for: .normal)
        self.toLoginButton.setTitle("To Login", for: .normal)
        self.emailTextField.isHidden = false
    }

    func showLogin() {
        if let toolbar = toolbarController?.toolbar {
            toolbar.title = "Login"
        }
        self.loginButton.setTitle("Login", for: .normal)
        self.toLoginButton.setTitle("To Signup", for: .normal)
        self.emailTextField.isHidden = true
    }

    func showSnackBar(text: String) {
        guard let snackbarController = snackbarController else { return }
        snackbarController.snackbar.text = text
        snackbarController.animate(snackbar: .visible, delay: 1)
        snackbarController.animate(snackbar: .hidden, delay: 4)
    }
}
