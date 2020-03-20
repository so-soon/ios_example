//
//  AppDelegate.swift
//  LoginFlow
//
//  Created by soonhyuk on 2020/03/10.
//  Copyright © 2020 soonhyuk. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("just before launching app")
        return true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        print("right after launching app")
        return true
    }

    
    func applicationWillResignActive(_ application: UIApplication) {
        print("app will be deactivated")
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("app enter the background")
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        print("app will escape background")
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        print("app is activated")
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        print("right before app is terminated")
    }
    
    
    // MARK: UISceneSession Lifecycle

    

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

