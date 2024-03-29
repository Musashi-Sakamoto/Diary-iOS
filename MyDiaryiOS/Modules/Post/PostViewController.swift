//
//  PostViewController.swift
//  MyDiaryiOS
//
//  Created by Musashi Sakamoto on 2019/06/10.
//  Copyright © 2019 musashi. All rights reserved.
//

import AVFoundation
import Material
import UIKit

class PostViewController: UIViewController {
    var presenter: PostPresenterInterface!

    @IBOutlet var postButton: RaisedButton!
    @IBOutlet var titleTextField: TextField!
    @IBOutlet var descriptionTextView: UITextView!
    var imageView: UIImageView?
    var videoContainerView: VideoContainerView?
    var movieUrl: URL?
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
        self.postButton.title = self.presenter.isEditing() ? "Edit" : "Post"
    }

    @IBAction func cancelButtonHandler(_ sender: Button) {
        self.presenter.cancelButtonClicked()
    }

    @IBAction func postButtonHandler(_ sender: Button) {
        var data: Data?
        var isImage = false
        if let image = imageView?.image {
            data = image.jpegData(compressionQuality: 0.9)
            isImage = true
        } else if let movie = movieUrl {
            data = try! Data(contentsOf: movie, options: .mappedIfSafe)
        }
        if self.presenter.isEditing() {
            self.presenter.editButtonClicked(title: self.titleTextField.text!, description: self.descriptionTextView.text, postId: self.presenter.getPostId()!, data: data, isImage: isImage)
        } else {
            self.presenter.postButtonClicked(title: self.titleTextField.text!, description: self.descriptionTextView.text, data: data, isImage: isImage)
        }
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
            view.layout(self.imageView!).width(UIScreen.main.bounds.width - 16).height(300).centerX().above(self.postButton, 64).below(self.descriptionTextView, 8)
        } else if let movieUrl = info[.mediaURL] as? URL {
            self.movieUrl = movieUrl
            self.videoContainerView = VideoContainerView()
            let avPlayer = AVPlayer(url: movieUrl)
            self.videoContainerView?.set(player: avPlayer)
            self.videoContainerView?.play()
            view.layout(self.videoContainerView!).width(UIScreen.main.bounds.width - 16)
                .height(300).centerX().above(self.postButton, 64)
        }
        dismiss(animated: true, completion: nil)
    }
}

extension PostViewController: PostViewInterface {
    func showEditedPost(post: PostInterface?) {
        guard let editedPost = post as? PostViewItemInterface else { return }
        self.titleTextField.text = editedPost.mainTitle
        self.descriptionTextView.text = editedPost.description
        self.postButton.title = "Edit"

        guard let media = editedPost.media else { return }
        if media == .image {
            self.imageView = UIImageView()
            self.imageView?.af_setImage(withURL: editedPost.imageURL!)
            view.layout(self.imageView!).width(UIScreen.main.bounds.width - 16).height(300).centerX().above(self.postButton, 64).below(self.descriptionTextView, 8)
        } else if media == .video {
            self.videoContainerView = VideoContainerView()
            let player = AVPlayer(url: editedPost.imageURL!)
            self.videoContainerView?.set(player: player)
            self.videoContainerView?.play()
            view.layout(self.videoContainerView!).width(UIScreen.main.bounds.width - 16)
                .height(300).centerX().above(self.postButton, 64)
        }
    }
}
