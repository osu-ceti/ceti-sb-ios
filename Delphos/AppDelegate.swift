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
    
    func authenticateUser() -> Bool  {
        
        if let authkey = userCredsStorage.string(forKey: gAuthenticationKey) {
            logger.log(LoggingLevel.INFO, message: "Auth token found")
            gObjUserBean = UserBean()
            gObjUserBean.authentication_token = authkey
            
           

           if let biography = userCredsStorage.string(forKey: gBiographyKey) {
                gObjUserBean.biography = biography
            }
            if let business = userCredsStorage.string(forKey: gBusinessKey ){
                gObjUserBean.business = business
            }
            if let email = userCredsStorage.string(forKey: gEmailKey){
                gObjUserBean.email = email
            }
            if let grades = userCredsStorage.string(forKey: gGradesKey){
                gObjUserBean.grades = grades
            }
            
            if let id = userCredsStorage.string(forKey: gIdKey){
                gObjUserBean.id = Int(id)

            }
            if let grades = userCredsStorage.string(forKey: gJobTitleKey){
                 gObjUserBean.grades = grades
            }
            if let name = userCredsStorage.string(forKey: gNameKey){
                gObjUserBean.name = name
            }
            
            if let role = userCredsStorage.string(forKey: gRolekey){
                gObjUserBean.role
                    = Int(role)
            }
            if let schoolId = userCredsStorage.string(forKey: gSchoolIdKey){
                 gObjUserBean.school_id = Int(schoolId)
            }
            if let schoolName = userCredsStorage.string(forKey: gSchoolNameKey){
                gObjUserBean.school_name = schoolName
            }
            if let passKey = userCredsStorage.string(forKey: gStrUserStoragePassKey){
                gPasswordCheck = passKey
                //print("passKey",passKey)
            }

           
                      
            return true
            
        }
        else{
         
            return false
        }
        
    }

    
    fileprivate func createMenuView() {
        
        // create viewController code...
        
        
        var mainViewController :UIViewController
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if(authenticateUser()){
            mainViewController = storyboard.instantiateViewController(withIdentifier: "HomeID") as! HomeController
        }
        else{
            mainViewController = storyboard.instantiateViewController(withIdentifier: "loginId") as! LoginController
        }
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
        // use UIStackView
        gStrDeviceToken = deviceToken.description.trimmingCharacters(in: CharacterSet.init(charactersIn: "<>")).replacingOccurrences(of: " ", with: DelphosStrings.EMPTY_STRING)
        if (gStrDeviceToken == "32bytes") {
            
            let token = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
            
            print("Registration succeeded!")
            
            print("DEVICE TOKEN = \(token)")
            
            //if(deviceToken != ""){
            gStrDeviceToken = token.description.trimmingCharacters(in: CharacterSet.init(charactersIn: "<>")).replacingOccurrences(of: " ", with: "")
            print("Device Token = " + gStrDeviceToken)

        }
        
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
        notificationPage = 1
        facade.doTask(gObjRightViewController!, action: DelphosAction.show_NOTIFICATION)
//        facade.doTask(UIViewController(), action: DelphosAction.VIEW_BADGE_AWARD)
        
    }
    func handleRemotePush(_ bgInfo: UIBackgroundFetchResult) -> Void{
        print("Handling remote push\n")
        print (bgInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification notificationInfo: [AnyHashable: Any], handleRemotePush completionHandler: (UIBackgroundFetchResult) -> Void) {
        print("Entering fetchCompletionHandler\n")
        print(notificationInfo)
        notificationPage = 1
        gObjNotificationInfo = notificationInfo as AnyObject?
        facade.doTask(gObjRightViewController!, action: DelphosAction.show_NOTIFICATION)
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

