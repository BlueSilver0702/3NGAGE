//
//  AppDelegate.swift
//  3NGAGE
//
//  Created by Blue Silver on 3/3/16.
//  Copyright © 2016 Blue Silver. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var g_var: Global!
    var mainStoryboard: UIStoryboard!
    var rightMenu: MenuViewController!


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        application.statusBarStyle = UIStatusBarStyle.LightContent
        
        mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        rightMenu = mainStoryboard.instantiateViewControllerWithIdentifier("menuCtrl") as! MenuViewController
        
        SlideNavigationController.sharedInstance().rightMenu = rightMenu;
        SlideNavigationController.sharedInstance().leftMenu = nil;
        SlideNavigationController.sharedInstance().portraitSlideOffset = 180;
        
        QBSettings.setApplicationID(36808)
        QBSettings.setAuthKey("zWg-eNZtzO2HsJW")
        QBSettings.setAuthSecret("VQ22MMFZbxGqZ3O")
        QBSettings.setAccountKey("cX3Sp3JgJupNSfZmdcpx")
        
        SVProgressHUD.setBackgroundColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.6))
        SVProgressHUD.setForegroundColor(UIColor(red: 237/255.0, green: 2/255.0, blue: 140/255.0, alpha: 1.0))
        
        g_var = Global()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

