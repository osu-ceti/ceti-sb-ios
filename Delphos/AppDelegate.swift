		//
//  AppDelegate.swift
//  Delphos
//
//  Created by Prabhu on 5/6/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//

import UIKit
import  CocoaLumberjack

@UIApplicationMain


class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var facade: FacadeDelphos
    
    override init(){
        facade = FacadeDelphos()
        logger = Logger()
    }
    
    func getObjFacade() -> FacadeDelphos
    {
        return facade
    }
    
    func getLogger() -> Logger
    {
        return logger
    }
    
    fileprivate func createMenuView() {
        
        // create viewController code...
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "loginId") as! LoginController
       
         rightViewController = storyboard.instantiateViewController(withIdentifier: "RightViewController") as! RightViewController
        
        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
        UINavigationBar.appearance().tintColor = UIColor.blue
        
        
        
        let slideMenuController = SlidingMenuController(mainViewController:nvc, rightMenuViewController: rightViewController)
        
        self.window?.backgroundColor = UIColor.white
        self.window?.rootViewController = slideMenuController
        rootViewController = slideMenuController
        self.window?.makeKeyAndVisible()
    }
    
    func registerForPushNotifications(_ application: UIApplication){
        let notificationTypes: UIUserNotificationType = [UIUserNotificationType.alert, UIUserNotificationType.badge, UIUserNotificationType.sound]
        let pushNotificationSettings = UIUserNotificationSettings(types: notificationTypes, categories: nil)
        application.registerUserNotificationSettings(pushNotificationSettings)
        application.registerForRemoteNotifications()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //Creating SlideMenuController
        self.createMenuView()
        
        //Register for Push  Notifications
        //self.registerForPushNotifications(application)
        
        
        self.registerForPushNotifications(application)
        
        DDLog.add(DDASLLogger.sharedInstance())
        DDLog.add(DDTTYLogger.sharedInstance())
        
        let fileLogger: DDFileLogger = DDFileLogger() // File Logger
        fileLogger.rollingFrequency = TimeInterval(60*60*24)  // 24 hours
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
        DDLog.add(fileLogger)
        
        DDLogVerbose("Verbose");
        DDLogDebug("Debug");
        DDLogInfo("Info");
        DDLogWarn("Warn");
        DDLogError("Error");
        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data){
        if #available(iOS 10.0, *) {
            
            let token = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
            
            print("Registration succeeded!")
            
            print("DEVICE TOKEN = \(token)")
            
            //if(deviceToken != ""){
            gStrDeviceToken = token.description.trimmingCharacters(in: CharacterSet.init(charactersIn: "<>")).replacingOccurrences(of: " ", with: "")
            print("Device Token = " + gStrDeviceToken)

        }
        else{
            
            // use UIStackView
            gStrDeviceToken = deviceToken.description.trimmingCharacters(in: CharacterSet.init(charactersIn: "<>")).replacingOccurrences(of: " ", with: DelphosStrings.EMPTY_STRING)
        }
        
        // }
        
    }
    
//    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data){
//        print("DEVICE TOKEN = \(deviceToken)")
//        
//        //if(deviceToken != DelphosStrings.EMPTY_STRING){
//        gStrDeviceToken = deviceToken.description.trimmingCharacters(in: CharacterSet.init(charactersIn: "<>")).replacingOccurrences(of: " ", with: DelphosStrings.EMPTY_STRING)
//        print("Device Token = " + gStrDeviceToken)
//        
//       // }
//        
//    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error)
    }
    
    
   
    func application(_ application: UIApplication, didReceiveRemoteNotification notificationInfo: [AnyHashable: Any]) {
        print("Entering didReceiveRemoteNotification\n")
        print(notificationInfo)
        gObjNotificationInfo = notificationInfo as AnyObject?
        
       // rootViewController.showOverlay(self.rootViewController)
        
        facade.doTask(gObjRightViewController!, action: DelphosAction.handle_NOTIFICATION)
//        facade.doTask(UIViewController(), action: DelphosAction.VIEW_BADGE_AWARD)
        
    }
    func handleRemotePush(_ bgInfo: UIBackgroundFetchResult) -> Void{
        print("Handling remote push\n")
        print (bgInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification notificationInfo: [AnyHashable: Any], handleRemotePush completionHandler: (UIBackgroundFetchResult) -> Void) {
        print("Entering fetchCompletionHandler\n")
        print(notificationInfo)
        gObjNotificationInfo = notificationInfo as AnyObject?
        facade.doTask(gObjRightViewController!, action: DelphosAction.handle_NOTIFICATION)
    }
    
    
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        print("applicationDidEnterBackground")
    }
    
    func application( _ application: UIApplication,
                       didReceive notification: UILocalNotification){
        print("didReceiveLocalNotification")
    }
    


    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        print("applicationDidBecomeActive")
        print(window?.rootViewController)
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

