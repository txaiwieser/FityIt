//
//  GameViewController.swift
//  FityIt
//
//  Created by Txai Wieser on 13/03/18.
//  Copyright © 2018 Txai Wieser. All rights reserved.
//

import UIKit
import SpriteKit
import TWSpriteKitUtils

class GameViewController: UIViewController {
    var gameView: SKView { return view as! SKView }
    
    override func loadView() {
        let skView = SKView()
        skView.frame = UIScreen.main.bounds
        skView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        skView.showsFPS = BUILD_MODE == .debug
        skView.showsNodeCount = BUILD_MODE == .debug
        skView.showsPhysics = BUILD_MODE == .debug
        skView.ignoresSiblingOrder = true
        view = skView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        TWButton.defaultSoundEffects[.touchUpInside] = "button_up.wav"
        TWButton.defaultSoundEffects[.touchDown] = "button_down.wav"
        _ = SKAction.reloadSoundEffectsSettings()
        
        let overlayView = UIImageView(image: UIImage(named: "bg1"))
        overlayView.contentMode = .scaleAspectFill
        overlayView.isUserInteractionEnabled = false
        overlayView.alpha = 0.13
        view.addSubview(overlayView)
        
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        overlayView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        overlayView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        #if SNAPSHOT
            AppPersistence.resetUserDefaults()
            AppPersistence.highScorePoints = 77
            let scene = InitialScene(score: Score(points: 14))
            gameView.presentScene(scene)
        #else
            let scene = InitialScene(score: nil)
            gameView.presentScene(scene)
        #endif
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        GameCenter.shared.authenticateLocalUser()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        if let scene = gameView.scene as? InitialScene {
            scene.gameScene = nil
        }
    }
    
    func gameEndedPresentAdAndInitialScene(_ scene: SKScene) {
        gameView.presentScene(scene, transition: AppDefines.Transition.toInitial)
    }
}
