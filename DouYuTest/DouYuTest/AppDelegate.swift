//
//  AppDelegate.swift
//  DouYuTest
//
//  Created by jack_tang on 17/1/5.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
            UITabBar.appearance().tintColor = UIColor.orange
        window =  UIWindow(frame: UIScreen.main.bounds);
        window?.rootViewController = MainViewController()
        window?.makeKeyAndVisible()
        
        return true
    }

  

}

