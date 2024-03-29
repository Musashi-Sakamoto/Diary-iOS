//
//  PostWireframe.swift
//  MyDiaryiOS
//
//  Created by Musashi Sakamoto on 2019/06/10.
//  Copyright © 2019 musashi. All rights reserved.
//

import Foundation
import UIKit

final class PostWireframe: BaseWireframe {
    private let _storyboard = UIStoryboard(name: "Post", bundle: nil)

    init() {
        let moduleViewController = self._storyboard.instantiateViewController(withIdentifier: "PostViewController") as! PostViewController
        super.init(viewController: moduleViewController)

        let interactor = PostInteractor()
        let presenter = PostPresenter(wireframe: self, view: moduleViewController, interactor: interactor)
        interactor.presenter = presenter
        moduleViewController.presenter = presenter
    }
}

extension PostWireframe: PostWireframeInterface {
    func navigate(to option: PostNavigationOption) {
        switch option {
        case .dismiss:
            viewController.dismiss(animated: true, completion: nil)
        case .library:
            self._openImagePicker()
        }
    }

    private func _openImagePicker() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()
            picker.delegate = viewController as? PostViewController
            picker.mediaTypes = ["public.movie", "public.image"]
            picker.sourceType = .photoLibrary
            viewController.present(picker, animated: true, completion: nil)
        }
    }
}
