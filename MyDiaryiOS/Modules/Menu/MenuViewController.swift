//
//  MenuViewController.swift
//  MyDiaryiOS
//
//  Created by Musashi Sakamoto on 2019/06/08.
//  Copyright © 2019 musashi. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {
    var presenter: MenuPresenterInterface!

    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
    @IBAction func logoutButtonHandler(_ sender: UIButton) {
        self.presenter.logoutButtonClicked()
    }
}

extension MenuViewController: MenuViewInterface {
    func showProfileInfo(username: String, email: String) {
        self.usernameLabel.text = username
        self.emailLabel.text = email
    }
}
