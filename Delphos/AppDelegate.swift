//
//  AppDelegate.swift
//  Delphos
//
//  Created by Prabhu on 5/6/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var facade: FacadeDelphos
    override init(){
        facade = FacadeDelphos()
    }
    
    func getObjFacade() -> FacadeDelphos
    {
        
        return facade
    }
    private func createMenuView() {
        
        // create viewController code...
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let mainViewController = storyboard.instantiateViewControllerWithIdentifier("loginId") as! LoginController
       
         rightViewController = storyboard.instantiateViewControllerWithIdentifier("RightViewController") as! RightViewController
        
        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
        UINavigationBar.appearance().tintColor = UIColor.blueColor()
        
        
        
        let slideMenuController = SlidingMenuController(mainViewController:nvc, rightMenuViewController: rightViewController)
        
        self.window?.backgroundColor = UIColor.whiteColor()
        self.window?.rootViewController = slideMenuController
        rootViewController = slideMenuController
        self.window?.makeKeyAndVisible()
    }
    
    func registerForPushNotifications(application: UIApplication){
        let notificationTypes: UIUserNotificationType = [UIUserNotificationType.Alert, UIUserNotificationType.Badge, UIUserNotificationType.Sound]
        let pushNotificationSettings = UIUserNotificationSettings(forTypes: notificationTypes, categories: nil)
        application.registerUserNotificationSettings(pushNotificationSettings)
        application.registerForRemoteNotifications()
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        //Creating SlideMenuController
        self.createMenuView()
        
        //Register for Push  Notifications
        self.registerForPushNotifications(application)
        
        return true
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData){
        print("DEVICE TOKEN = \(deviceToken)")
        gStrDeviceToken = deviceToken.description.stringByTrimmingCharactersInSet(NSCharacterSet.init(charactersInString: "<>")).stringByReplacingOccurrencesOfString(" ", withString: "")
        print("Device Token = " + gStrDeviceToken)
        
        
        
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print(error)
    }
    
    
   
    func application(application: UIApplication, didReceiveRemoteNotification notificationInfo: [NSObject : AnyObject]) {
        print("Entering didReceiveRemoteNotification\n")
        print(notificationInfo)
        gObjNotificationInfo = notificationInfo
        
       // rootViewController.showOverlay(self.rootViewController)
        
        facade.doTask(UIViewController(), action: DelphosAction.HANDLE_NOTIFICATION)
//        facade.doTask(UIViewController(), action: DelphosAction.VIEW_BADGE_AWARD)
        
    }
    func handleRemotePush(bgInfo: UIBackgroundFetchResult) -> Void{
        print("Handling remote push\n")
        print (bgInfo)
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification notificationInfo: [NSObject : AnyObject], handleRemotePush completionHandler: (UIBackgroundFetchResult) -> Void) {
        print("Entering fetchCompletionHandler\n")
        print(notificationInfo)
        gObjNotificationInfo = notificationInfo
        facade.doTask(UIViewController(), action: DelphosAction.HANDLE_NOTIFICATION)
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        print("applicationDidEnterBackground")
    }
    
    func application( application: UIApplication,
                       didReceiveLocalNotification notification: UILocalNotification){
        print("didReceiveLocalNotification")
    }
    


    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        print("applicationDidBecomeActive")
        print(window?.rootViewController)
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

