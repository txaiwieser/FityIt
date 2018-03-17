//
//  SplashScreenViewController.swift
//  FityIt
//
//  Created by Txai Wieser on 13/03/18.
//  Copyright © 2018 Txai Wieser. All rights reserved.
//

import UIKit

class SplashScreenViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GCHelper.sharedInstance.authenticateLocalUser()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        AppCache.instance.resetSounds(initializeAfter: true)
        AppCache.instance.initializeInitialScreenBackgroundTexture(screenSize: InitialScene.calculateSceneSize(self.view.frame.size))
        
        delay(0.3) {
            let vc = AppDelegate.gameViewController
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)
        }
    }
}
