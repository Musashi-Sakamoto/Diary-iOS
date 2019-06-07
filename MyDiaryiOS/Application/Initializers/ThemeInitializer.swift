//
//  ThemeInitializer.swift
//  MyDiaryiOS
//
//  Created by 坂元 武佐志 on 2019/06/07.
//  Copyright © 2019 musashi. All rights reserved.
//

import UIKit

class ThemeInitializer: Initializerable {
    func performInitialization() {
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        UINavigationBar.appearance().barTintColor = .purple
    }
}
