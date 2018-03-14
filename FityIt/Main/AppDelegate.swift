//
//  AppDelegate.swift
//  FityIt
//
//  Created by Txai Wieser on 13/03/18.
//  Copyright © 2018 Txai Wieser. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    static var instance: AppDelegate { return UIApplication.shared.delegate as! AppDelegate }
    
    var window: UIWindow?
    var gameViewController: GameViewController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        #if DEBUG && !SNAPSHOT
            BUILD_MODE = .debug
        #else
            BUILD_MODE = .release
        #endif
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.backgroundColor = UIColor.white
        window!.makeKeyAndVisible()
        window!.rootViewController = SplashScreenViewController()
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        PersistenceHandler.resetPlayedSectionPlayedMatches()
        ((self.gameViewController?.view as? SKView)?.scene as? GameScene)?.updateTimer.lap()
    }
}

