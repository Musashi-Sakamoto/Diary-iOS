//
//  MenuInterface.swift
//  MyDiaryiOS
//
//  Created by Musashi Sakamoto on 2019/06/10.
//  Copyright © 2019 musashi. All rights reserved.
//

import Alamofire
import Foundation

enum MenuNavigationOption {
    case edit
    case login
}

protocol MenuWireframeInterface: WireframeInterface {
    func navigate(to option: MenuNavigationOption)
}

protocol MenuViewInterface: ViewInterface {
    func showProfileInfo(user: UserInterface?)
}

protocol MenuPresenterInterface: PresenterInterface {
    func logoutButtonClicked()
    func showProfileInfo(user: UserInterface?)
}

protocol MenuInteractorInterface: InteractorInterface {
    func logout(completion: @escaping LogoutCompletionBlock) -> DataRequest
}
