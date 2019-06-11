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

protocol MenuViewInterface: ViewInterface {}

protocol MenuPresenterInterface: PresenterInterface {
    func logoutButtonClicked()
}

protocol MenuInteractorInterface: InteractorInterface {
    func logout(completion: @escaping LogoutCompletionBlock) -> DataRequest
}
