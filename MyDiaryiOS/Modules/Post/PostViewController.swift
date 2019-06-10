//
//  PostViewController.swift
//  MyDiaryiOS
//
//  Created by Musashi Sakamoto on 2019/06/10.
//  Copyright © 2019 musashi. All rights reserved.
//

import Material
import UIKit

class PostViewController: UIViewController {
    var presenter: PostPresenterInterface!

    @IBOutlet var titleTextField: TextField!
    @IBOutlet var descriptionTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func cancelButtonHandler(_ sender: Button) {
        self.presenter.cancelButtonClicked()
    }

    @IBAction func postButtonHandler(_ sender: Button) {
        self.presenter.postButtonClicked(title: self.titleTextField.text!, description: self.descriptionTextView.text)
    }
}

extension PostViewController: PostViewInterface {}
