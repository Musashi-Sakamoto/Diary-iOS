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
        moduleViewController.presenter = presenter
    }
}

extension PostWireframe: PostWireframeInterface {
    func navigate(to option: PostNavigationOption) {
        switch option {
        case .dismiss:
            viewController.dismiss(animated: true, completion: nil)
        }
    }
}
