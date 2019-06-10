//
//  PostListWireframe.swift
//  MyDiaryiOS
//
//  Created by 坂元 武佐志 on 2019/06/06.
//  Copyright © 2019 musashi. All rights reserved.
//

import UIKit

final class PostListWireframe: BaseWireframe {
    private let _storyboard = UIStoryboard(name: "PostList", bundle: nil)

    init() {
        let moduleViewController = self._storyboard.instantiateViewController(withIdentifier: "PostListViewController") as! PostListViewController
        super.init(viewController: moduleViewController)

        let interactor = PostListInteractor()
        let presenter = PostListPresenter(wireframe: self, view: moduleViewController, interactor: interactor)
        moduleViewController.presenter = presenter
    }
}

extension PostListWireframe: PostListWireframeInterface {
    func navigate(to option: PostListNavigationOption) {
        switch option {
        case .login:
            self._openLogin()
        case .add:
            let postCreateWireframe = PostWireframe()
            navigationController?.presentWifreframe(postCreateWireframe)
        default:
            print("detault")
        }
    }

    private func _openLogin() {
        navigationController?.popViewController(animated: true)
    }
}
