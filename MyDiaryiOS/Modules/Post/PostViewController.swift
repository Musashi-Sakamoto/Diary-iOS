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

    @IBOutlet var postButton: RaisedButton!
    @IBOutlet var titleTextField: TextField!
    @IBOutlet var descriptionTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self._setupView()
    }

    private func _setupView() {
        let button = FABButton(image: Icon.cm.photoLibrary, tintColor: .white)
        button.pulseColor = .white
        button.backgroundColor = .purple
        view.layout(button).width(48).height(48).above(self.postButton, 8).trailing(self.postButton)

        self.postButton.pulseColor = .white
        self.postButton.titleColor = .white
        self.postButton.backgroundColor = .purple
    }

    @IBAction func cancelButtonHandler(_ sender: Button) {
        self.presenter.cancelButtonClicked()
    }

    @IBAction func postButtonHandler(_ sender: Button) {
        self.presenter.postButtonClicked(title: self.titleTextField.text!, description: self.descriptionTextView.text)
    }
}

extension PostViewController: PostViewInterface {}
