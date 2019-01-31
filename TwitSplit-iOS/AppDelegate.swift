//
//  AppDelegate.swift
//  TwitSplit-iOS
//
//  Created by MD on 7/10/18.
//  Copyright © 2018 MD. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupUI()
        return true
    }
    
    private func setupUI() {
        UINavigationBar.appearance().barTintColor = UIColor.hex(hex: kMainColor)
        UINavigationBar.appearance().tintColor = UIColor.white

        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor.white
        ]
        
        UIApplication.shared.statusBarStyle = .lightContent
    }

}

