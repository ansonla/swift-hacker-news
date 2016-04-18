//
//  AppDelegate.swift
//  qanta
//
//  Created by Chuck Man on 18/04/2016.
//  Copyright © 2016 Chuck Man. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var demoController: UINavigationController?

    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
    {
        self.createWindow()
        self.run()
        
        return true
    }

    func createWindow()
    {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
    }
    
    func run()
    {
        demoController = UINavigationController(rootViewController: HNViewController())
        
        window?.rootViewController = demoController
        window?.makeKeyAndVisible()
    }
}

