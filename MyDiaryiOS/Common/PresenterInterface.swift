//
//  PresenterInterface.swift
//  MyDiaryiOS
//
//  Created by 坂元 武佐志 on 2019/06/05.
//  Copyright © 2019 musashi. All rights reserved.
//

import Foundation

protocol PresenterInterface: AnyObject {
    func viewDidLoad()
    func viewWillAppear(animated: Bool)
    func viewDidAppear(animated: Bool)
    func viewWillDisappear(animated: Bool)
    func viewDidDisappear(animated: Bool)
}

extension PresenterInterface {
    func viewDidLoad() {
        fatalError("Implementation pending...")
    }

    func viewWillAppear(animated _: Bool) {
        fatalError("Implementation pending...")
    }

    func viewDidAppear(animated _: Bool) {
        fatalError("Implementation pending...")
    }

    func viewWillDisappear(animated _: Bool) {
        fatalError("Implementation pending...")
    }

    func viewDidDisappear(animated _: Bool) {
        fatalError("Implementation pending...")
    }
}
