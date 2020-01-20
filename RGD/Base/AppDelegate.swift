//
//  AppDelegate.swift
//  RGD
//
//  Created by SapratigsMACMini on 09/11/19.
//  Copyright © 2019 SapratigsMACMini. All rights reserved.
//
// com.GreenSport.dev
//
import UIKit
import IQKeyboardManagerSwift
import Alamofire
import Firebase


var deviceTokenStrig : String = "0"
var firebaseTokenStrig : String = "0"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static let shared : AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var NoNetworkViewController = NoNetworkVc(nibName: "NoNetworkVc", bundle: nil)
//    var MyLoaderViewController = MyLoaderVC(nibName: "MyLoaderVC", bundle: nil)
    let reachabilityManager = NetworkReachabilityManager()
    var slideMenuController = SlideMenuController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        sleep(3)
        
        self.basicKeyBoardSetUp()
        
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        Messaging.messaging().isAutoInitEnabled = true
        Messaging.messaging().subscribe(toTopic: "GeneralNotificationIOS") { error in
            print("Subscribed to weather topic")
            
        }
        Messaging.messaging().delegate = self
        
        self.createMenuView()
//        GFunction.sharedMethods.navigateUser()
//        GFunction.sharedMethods.getLocationsCurrencyLanguageApi()
        
        self.perform(#selector(self.intiInternetRelachable), with: nil, afterDelay: 1.0)
        
        //For device token
        UIApplication.shared.registerForRemoteNotifications()

        func registerForPushNotifications() {
            UNUserNotificationCenter.current() // 1
                .requestAuthorization(options: [.alert, .sound, .badge]) { // 2
                    granted, error in
                    print("Permission granted: \(granted)") // 3
                    UIApplication.shared.registerForRemoteNotifications()
            }
        }
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        // Override point for customization after application launch.
        return true
    }

    // This method is where you handle URL opens if you are using a native scheme URLs (eg "yourexampleapp://")
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return false
    }
    
    // This method is where you handle URL opens if you are using univeral link URLs (eg "https://example.com/stripe_ios_callback")
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        return false
    }

    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        self.perform(#selector(self.intiInternetRelachable), with: nil, afterDelay: 1.0)
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate {
    
    func createMenuView() {
        
        // create viewController code...
        let mainViewController = kMainBoard.instantiateViewController(withIdentifier: "NewsListVC") as! NewsListVC
        let leftViewController = kMainBoard.instantiateViewController(withIdentifier: "MenuVC") as! MenuVC
        
        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
        nvc.isNavigationBarHidden = true
        
        slideMenuController = SlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController)
        slideMenuController.automaticallyAdjustsScrollViewInsets = true
        //        slideMenuController.automaticallyAdjustsScrollViewInsets = true
        
        slideMenuController.delegate = mainViewController as? SlideMenuControllerDelegate
        self.window?.backgroundColor = colors.ColorTheamGreen1_02652E
        self.window?.rootViewController = slideMenuController
        
        self.window?.makeKeyAndVisible()
        
    }
    
    //------------------------------------------------------
    
    //MARK:- KeyBoard
    
    func basicKeyBoardSetUp() {
        IQKeyboardManager.shared.enable = true
        //        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        //        IQKeyboardManager.sharedManager().enableAutoToolbar = true
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 5
        //        IQKeyboardManager.sharedManager().keyboardDistanceFromTextField         = 5
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        //        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysShow
        //        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
    }
    // ------------------------------------------------------
    
    @objc func intiInternetRelachable()  {
        
        reachabilityManager?.startListening()
        /*
        reachabilityManager?.listener = { _ in
            if let isNetworkReachable = self.reachabilityManager?.isReachable,
                isNetworkReachable == true {
                //Internet Available
                /*
                let window: UIWindow? = UIApplication.shared.keyWindow
                
                let root: UIViewController = window!.rootViewController!
                
                root.dismiss(animated: true, completion: nil)
                */
                self.NoNetworkViewController.dismiss(animated: true, completion: {
                    
                })
            } else {
                //Internet Not Available"
//                self.removeMyLoader()
                let root: UIViewController = self.window!.rootViewController!
                self.NoNetworkViewController.dismiss(animated: true, completion: {
                    
                })
                
                root.definesPresentationContext = true
                root.providesPresentationContextTransitionStyle = true
                self.NoNetworkViewController.modalPresentationStyle = .overCurrentContext
                
                root.present(self.NoNetworkViewController, animated: true, completion: nil)
            }
        }
        */
        
    }

    

    
}

extension AppDelegate : MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print(messaging)
        print(remoteMessage)
        
    }
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        
        let dataDict:[String: String] = ["token": fcmToken]
        firebaseTokenStrig = fcmToken
//        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
//
//        self.perform(#selector(self.delayForFirebaseDeviceUpdate), with: nil, afterDelay: 2.0)
        Messaging.messaging().delegate = self
        Messaging.messaging().isAutoInitEnabled = true
        Messaging.messaging().subscribe(toTopic: "GeneralNotificationIOS") { error in
            print("Subscribed to weather topic")
            
        }
        Messaging.messaging().delegate = self
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
}

extension UIApplication {
    
    //    var statusBarView: UIView? {
    //        return value(forKey: "statusBar") as? UIView
    //    }
    
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        /*
        if let controller = AppDelegate.shared.slideMenuController.mainViewController as? UIViewController {
         
            //            if let firstVC = controller.childViewControllers.first {
            //                return firstVC
            //            }
            if let firstVC = controller.children.first {
                return firstVC
            }
        }
        */
        return controller
    }
}
