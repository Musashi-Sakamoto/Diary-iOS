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
    var imageView: UIImageView?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self._setupView()
    }

    private func _setupView() {
        let button = FABButton(image: Icon.cm.photoLibrary, tintColor: .white)
        button.pulseColor = .white
        button.backgroundColor = .purple
        button.addTarget(self, action: #selector(self.addImageButtonClicked), for: .touchUpInside)
        view.layout(button).width(48).height(48).above(self.postButton, 8).trailing(self.postButton)

        self.postButton.pulseColor = .white
        self.postButton.titleColor = .white
        self.postButton.backgroundColor = .purple
    }

    @IBAction func cancelButtonHandler(_ sender: Button) {
        self.presenter.cancelButtonClicked()
    }

    @IBAction func postButtonHandler(_ sender: Button) {
        self.presenter.postButtonClicked(title: self.titleTextField.text!, description: self.descriptionTextView.text, image: self.imageView?.image)
    }

    @objc
    func addImageButtonClicked() {
        self.presenter.addMediaButtonClicked()
    }
}

extension PostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[.originalImage] as? UIImage {
            print("image: \(image)")
            self.imageView = UIImageView(image: image)
            view.layout(self.imageView!).width(UIScreen.main.bounds.width - 16).height(300).centerX().above(self.postButton, 64)
        }
        dismiss(animated: true, completion: nil)
    }
}

extension PostViewController: PostViewInterface {}
