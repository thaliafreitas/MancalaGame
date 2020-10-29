//
//  AppDelegate.swift
//  MancalaGame
//
//  Created by Thalia on 28/10/20.
//  Copyright © 2020 Thalia. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UserDefaults.standard.set(nil, forKey: "nickname")
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        SCKManager.shared.establishConnection()
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        SCKManager.shared.closeConnection()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        if let nickname = UserDefaults.standard.string(forKey: "nickname") {
            SCKManager.shared.exit(with: nickname, completionHandler: nil)
        }
    }

}

