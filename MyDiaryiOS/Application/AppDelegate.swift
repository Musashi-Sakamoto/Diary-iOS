//
//  AppDelegate.swift
//  MyDiaryiOS
//
//  Created by 坂元 武佐志 on 2019/06/05.
//  Copyright © 2019 musashi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    lazy var initializers: [Initializerable] = [
        AlamofireInitializer(),
        ThemeInitializer()
    ]

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.initializers.forEach { $0.performInitialization() }
        let initialController = UINavigationController()
        initialController.setRootWireframe(LoginWireframe())
        let appToolbarController = AppToolbarController(rootViewController: initialController)
        let navigationDrawerController = AppNavigatinoDrawerController(rootViewController: appToolbarController, menuWireframe: MenuWireframe())

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navigationDrawerController
        self.window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_: UIApplication) {
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_: UIApplication) {
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}
