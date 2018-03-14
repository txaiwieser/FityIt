//
//  AppDelegate.swift
//  FityIt
//
//  Created by Txai Wieser on 13/03/18.
//  Copyright © 2018 Txai Wieser. All rights reserved.
//

import SpriteKit
//import TWSpriteKitUtils

class InitialScene: SKScene {
//    static let LOGO_TOP_MARGIN:CGFloat = 25
//    static let buttomBetweenMargin:CGFloat = 20
//    static let btLabelsShift:CGFloat = 0.005
//
//    var score:Score?
//    var isInitialScene:Bool {
//        get {
//            return self.score == nil
//        }
//    }
//
    var gameScene: GameScene?
//
//    override func didMove(to view: SKView) {
//        super.didMove(to: view)
//        animationApear?()
//    }
//
//    override func willMove(from view: SKView) {
//        super.willMove(from: view)
//        animationDisapear?()
//    }
//
    init(score: Score?) {
        super.init(size: .zero)
    }
//        let newSize = InitialScene.calculateSceneSize()
//        super.init(size: newSize)
//        GCHelper.sharedInstance.authenticateLocalUser()
//        if !(Device.version() == .iPhone4S) && !(Device.version() == .iPhone6Plus) {
//            gameScene = GameScene()
//        }
//
//        self.score = score
//        if let newScore = score { PersistenceHandler.saveNewScore(newScore) }
//
//        backgroundColor = SKColor.black
//        GameSingleton.instance.initializeInitialScreenBackgroundTexture(newSize)
//        let gradientNode1 = SKSpriteNode(texture: GameSingleton.instance.initialScreenBackgroundTexture)
//        gradientNode1.position = CGPoint(size: newSize/2)
//        gradientNode1.position.y += newSize.height/4
//        gradientNode1.alpha = 1
//        gradientNode1.zPosition = 1
//        addChild(gradientNode1)
//
//        let gradientNode2 = SKSpriteNode(color: SKColor.darkerBlack(), size: CGSize(width: newSize.width, height: newSize.height/2))
//        gradientNode2.position = CGPoint(size: newSize/2)
//        gradientNode2.position.y -= newSize.height/4
//        gradientNode2.alpha = 1
//        gradientNode2.zPosition = 390
//        addChild(gradientNode2)
//
//        let is_iPhone4s = Device.size() == .screen3_5Inch
//        let is_iPad = UIDevice.current.userInterfaceIdiom == .pad
//        let iPadSize = CGSize(width: 326, height: 54)
//        let iPhoneSize = CGSize(width: (is_iPhone4s ? 212 : 216), height: (is_iPhone4s ? 34 : 30))
//        let mm = (is_iPad ? iPadSize : iPhoneSize)
//
//        removeAdsButton?.setAllStatesLabelFontSize(iPhoneSize.height*0.6)
//
//
//
//        let margin = SKSpriteNode(color: SKColor.clear, size: mm)
//
//        let circlesStack = TWStackNode(size: mm, fillMode: .horizontal)
//        circlesStack.add(node: playButton)
//        circlesStack.add(node: shareButton)
//        circlesStack.reloadStack()
//
//        let squaresStack = TWStackNode(size: mm, fillMode: .horizontal)
//        squaresStack.add(node: leaderboardButton)
//        squaresStack.add(node: soundButton)
//        squaresStack.add(node: rateButton)
//        squaresStack.reloadStack()
//
//        let bottomStack = TWStackNode(lenght: mm.width, fillMode: .vertical)
//        bottomStack.add(node: circlesStack)
//        bottomStack.add(node: margin)
//        bottomStack.add(node: squaresStack)
//        bottomStack.add(node: margin.copy() as! SKNode)
//
//        if let rem = removeAdsButton {
//            bottomStack.add(node: rem)
//        }
//        bottomStack.add(node: margin.copy() as! SKNode)
//        bottomStack.reloadStack()
//
//        bottomStack.position = CGPoint(x: newSize.width/2, y: bottomStack.size.height/2)
//        bottomStack.zPosition = 1000
//        addChild(bottomStack)
//
//        let multiplier: CGFloat = is_iPad ? 30 : 20
//
//
//        scoreC.alpha = 0
//        scoreC.setScore(self.score ?? Score(points: 0))
//        let topStack = TWStackNode(lenght: newSize.width, fillMode: .vertical)
//
//        topStack.position.y = newSize.height/4 - multiplier/2
//        topStack.position += CGPoint(size: newSize/2)
//        topStack.zPosition = 400
//        topStack.add(node: logo)
//        topStack.add(node: scoreC)
//        topStack.reloadStack()
//        addChild(topStack)
//
//
//        tutorialButton.position = CGPoint(size: newSize - tutorialButton.size/2)
//        tutorialButton.zPosition = 500
//        tutorialButton.alpha = 0
//        addChild(tutorialButton)
//
//
//        let track = SKSpriteNode(color: .white, size: CGSize(width: newSize.width+10, height: multiplier))
//        track.position = CGPoint(size: newSize/2)
//        track.position.y -= multiplier/2
//        track.zPosition = 400
//        addChild(track)
//
//
//        if DEBUG_GAME {
//            self.addChild(spinnerTests)
//            self.addChild(shapesTests)
//            self.addChild(endlessGameTest)
//            spinnerTests.zPosition = 500
//            shapesTests.zPosition = 500
//            endlessGameTest.zPosition = 500
//        }
//
//
//        animationApear = { [weak self] in
//            if let selfie = self {
//                var start = bottomStack.position - CGPoint(x: 0 , y: 2*(selfie.convert(.zero, from: bottomStack).y))
//
//                let ef1 = SKTMoveEffect(node: bottomStack, duration: 0.8, startPosition: start, endPosition: bottomStack.position)
//                ef1.timingFunction = SKTTimingFunctionBounceEaseOut
//                bottomStack.run(SKAction.actionWithEffect(ef1))
//
//                start = selfie.logo.position + CGPoint(x: 0, y: 2*(selfie.size.height - selfie.convert(.zero, from: selfie.logo).y))
//                let ef2 = SKTMoveEffect(node: selfie.logo, duration: 0.8, startPosition: start, endPosition: selfie.logo.position)
//                ef2.timingFunction = SKTTimingFunctionBounceEaseOut
//                selfie.logo.run(SKAction.actionWithEffect(ef2))
//
//                selfie.scoreC.run(SKAction.apearAnimated(selfie.scoreC, time: 0.9, scale: 1))
//
//                selfie.tutorialButton.run(SKAction.apearAnimated(selfie.tutorialButton, time: 0.8, scale: 1))
//            }
//
//        }
//
//        animationDisapear = { [weak self] in
//            if let selfie = self {
//                var end = bottomStack.position - CGPoint(x: 0 , y: 2*(selfie.convert(.zero, from: bottomStack).y))
//
//                let ef1 = SKTMoveEffect(node: bottomStack, duration: 0.2, startPosition: bottomStack.position, endPosition: end)
//                ef1.timingFunction = SKTTimingFunctionExponentialEaseIn
//                bottomStack.run(SKAction.actionWithEffect(ef1))
//
//                end = selfie.logo.position + CGPoint(x: 0, y: 2*(selfie.size.height - selfie.convert(.zero, from: selfie.logo).y))
//                let ef2 = SKTMoveEffect(node: selfie.logo, duration: 0.2, startPosition: selfie.logo.position, endPosition: end)
//                ef2.timingFunction = SKTTimingFunctionExponentialEaseIn
//                selfie.logo.run(SKAction.actionWithEffect(ef2))
//
//                selfie.scoreC.run(SKAction.disapearAnimated(selfie.scoreC, time: 0.3))
//
//
//                selfie.tutorialButton.run(SKAction.disapearAnimated(selfie.tutorialButton, time: 0.16))
//            }
//        }
//
//    }
//    var animationApear: (()->Void)? = nil
//    var animationDisapear: (()->Void)? = nil
//
//    deinit { print("->          AAAAA: MAIN LOG: Initial Scene released!") }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    static func calculateSceneSize(_ size: CGSize? = nil) -> CGSize {
        let size = size ?? AppDelegate.gameViewController.gameView.frame.size
        let isiPad = UIDevice.current.userInterfaceIdiom == .pad

        let defaultHeight: CGFloat = (isiPad ? 1024 : 640)
        let const = defaultHeight / size.height
        return CGSize(width: const * size.width, height: defaultHeight)
    }
    
//    // MARK: Buttons and banners
//
//
//    lazy var logo: SKSpriteNode = SKSpriteNode(texture: GameSingleton.instance.interface.textureNamed("fityit_logo"))
//    lazy var scoreC: ScoreContainer = ScoreContainer(texture: GameSingleton.instance.interface.textureNamed("score_container"))
//
//    lazy var playButton:TWButton = {
//        let bt = TWButton(normalTexture: GameSingleton.instance.interface.textureNamed("bt_play_n"), highlightedTexture : GameSingleton.instance.interface.textureNamed("bt_play_h"))
//
//        bt.addClosure(.touchUpInside, target: self, closure: { (currentScene, sender) -> () in
//            let scene = currentScene.gameScene ?? GameScene()
//            currentScene.removeUIandPresentScene(scene)
//        })
//        return bt
//        }()
//
//    lazy var tutorialButton:TWButton = {
//        let bt = TWButton(size: CGSize(width: 52, height: 52), normalColor: .clear, highlightedColor: nil)
//        bt.setNormalStateLabelText("?")
//        bt.setHighlightedStateSingleLabelText("?")
//        bt.setAllStatesLabelFontName(DEFAULT_FONT_NAME_LIGHT)
//        bt.setAllStatesLabelFontSize(24)
//        bt.setHighlightedStateSingleLabelFontColor(SKColor.white.withAlphaComponent(0.7))
//
//        bt.addClosure(.touchUpInside, target: self, closure: { (currentScene, sender) -> () in
//            let sc = currentScene.score
//            PersistenceHandler.alreadyPlayTutorial = false
//            let scene = GameScene()
//            currentScene.removeUIandPresentScene(scene)
//        })
//
//        return bt
//        }()
//
//    func removeUIandPresentScene(_ scene:SKScene) {
//        func present() {
//            GameViewController.gameView.presentScene(scene, transition: TRANSITION_TO_GAME)
//        }
//        if let anim = animationDisapear {
//            anim()
//            afterDelay(0.36) { present() }
//        } else {
//            present()
//        }
//    }
//
//    lazy var leaderboardButton:TWButton = {
//        let bt = TWButton(normalTexture: GameSingleton.instance.interface.textureNamed("bt_leaderboard_n"), highlightedTexture: GameSingleton.instance.interface.textureNamed("bt_leaderboard_h"))
//
//        bt.addClosure(.touchUpInside, target: self, closure: { (target, sender) -> () in
//            let sc = target.score
//            GCHelper.sharedInstance.showGameCenter(GameViewController.instance, viewState: .leaderboards, leaderboardID: MAIN_FITYIT_LEADERBOARD_ID)
//        })
//        return bt
//        }()
//
//    lazy var shareButton:TWButton = {
//        let bt = TWButton(normalTexture: GameSingleton.instance.interface.textureNamed("bt_share_n"), highlightedTexture: GameSingleton.instance.interface.textureNamed("bt_share_h"))
//
//        bt.addClosure(.touchUpInside, target: self, closure: { (currentScene, sender) -> () in
//            var objectsToShare = [Any]()
//            if let sc = currentScene.score {
//                let points = (sc.points == 1 ? "SHARE_MESSAGE_COMPLETE_POINT" : "SHARE_MESSAGE_COMPLETE_POINTS")
//                let textToShare = String(format:NSLocalizedString("SHARE_MESSAGE_COMPLETE", comment: ""), sc.points, NSLocalizedString(points, comment: ""), sc.highScorePoints())
//                objectsToShare.append(textToShare)
//            } else {
//                let textToShare = String(format:NSLocalizedString("SHARE_MESSAGE_TOP", comment: "message send when shared"), PersistenceHandler.getHighScorePoints())
//                objectsToShare.append(textToShare)
//            }
//
//            let i_imageSize = CGSize(width: 600, height: 400)
//            let i_view = SKView(frame: CGRect(origin: .zero, size: i_imageSize))
//
//            let overlayView = UIImageView(image: UIImage(named: "bg1"))
//            overlayView.frame = i_view.frame
//            overlayView.contentMode = .scaleAspectFill
//            overlayView.isUserInteractionEnabled = false
//            overlayView.alpha = 0.16
//            //        overlayView.blendmo
//            i_view.addSubview(overlayView)
//
//            let i_scene = ShareImageScene(size: i_imageSize, score: currentScene.score)
//            i_view.presentScene(i_scene)
//            let i_img = i_view.asImage()
//            objectsToShare.append(i_img)
//
//
//            if let myWebsite = iRate.sharedInstance().appStoreLink() {
//                objectsToShare.append(myWebsite)
//            }
//
//            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
//
//            //New Excluded Activities Code
//            activityVC.excludedActivityTypes = [.addToReadingList,
//                                                .assignToContact,
//                                                .postToFlickr,
//                                                .postToVimeo,
//                                                .print]
//
//            let vi = GameViewController.gameView
//            activityVC.popoverPresentationController?.sourceView = vi
//            activityVC.popoverPresentationController?.sourceRect = CGRect(origin: CGPoint(size: vi.frame.size/2), size: CGSize.zero)
//            activityVC.popoverPresentationController?.permittedArrowDirections = .up
//
//            GameViewController.instance.present(activityVC, animated: true, completion: nil)
//        })
//        return bt
//        }()
//
//    lazy var rateButton:TWButton = {
//        let bt = TWButton(normalTexture: GameSingleton.instance.interface.textureNamed("bt_rate_n"), highlightedTexture: GameSingleton.instance.interface.textureNamed("bt_rate_h"))
//
//        bt.addClosure(.touchUpInside, target: self, closure: { (target, sender) -> () in
//            let sc = target.score
//
//            let alert = UIAlertController(title: NSLocalizedString("RATE_ALERT_TITLE", comment: ""), message: NSLocalizedString("RATE_ALERT_MESSAGE", comment: ""), preferredStyle: .alert)
//
//            alert.addAction(UIAlertAction(title: NSLocalizedString("RATE_ALERT_YES", comment: ""), style: .default, handler: { (action:UIAlertAction) -> Void in
//
//                iRate.sharedInstance().openRatingsPageInAppStore()
//            }))
//
//            alert.addAction(UIAlertAction(title: NSLocalizedString("RATE_ALERT_CANCEL", comment: ""), style: .cancel, handler: nil))
//            GameViewController.instance.present(alert, animated: true, completion: nil)
//        })
//        return bt
//        }()
//
//    lazy var removeAdsButton: TWButton? = {
//        if PersistenceHandler.shouldDisplayAds {
//            let bt = TWButton(normalText: NSLocalizedString("REMOVE_ADS", comment: "removes advertisement"), highlightedText: NSLocalizedString("REMOVE_ADS", comment: "removes advertisement"))
//            bt.setAllStatesLabelFontName(DEFAULT_FONT_NAME_BOLD)
//            bt.setHighlightedStateSingleLabelFontColor(SKColor.lightBlack())
//            bt.addClosure(.touchUpInside, target: self, closure: { (target, sender) -> () in
//                GameViewController.instance.removeAdsInAppButtonAction()
//            })
//            return bt
//        } else {
//            return nil
//        }
//        }()
//
//    lazy var soundButton:TWSwitch = {
//        let sw = TWSwitch(normalTexture: GameSingleton.instance.interface.textureNamed("bt_sound_on_n"), selectedTexture: GameSingleton.instance.interface.textureNamed("bt_sound_off_n"))
//        sw.highlightedStateMultiTextureFromNormal = GameSingleton.instance.interface.textureNamed("bt_sound_on_h")
//        sw.highlightedStateMultiTextureFromSelected = GameSingleton.instance.interface.textureNamed("bt_sound_off_h")
//
//        sw.selected = !SKAction.shouldPlaySound()
//        sw.addClosure(.touchUpInside, target: self, closure: { (s, sender) -> () in
//            SKAction.saveNewSoundEffectsSettings(!sender.selected)
//        })
//        return sw
//        }()
//
//    lazy var spinnerTests:TWButton = {
//        let bt = TWButton(size: CGSize(width: 40, height: 40), normalColor: .white, highlightedColor: .black)
//        bt.position.y = self.size.height - bt.size.height/2
//        bt.position.x = 6*bt.size.width/2
//
//        bt.addClosure(.touchUpInside, target: self, closure: { (currentScene, sender) -> () in
//            let scene = SpinnerTestScene()
//            currentScene.view?.presentScene(scene, transition: TRANSITION_TO_GAME)
//        })
//        return bt
//        }()
//
//    lazy var shapesTests:TWButton = {
//        let bt = TWButton(size: CGSize(width: 40, height: 40), normalColor: .white, highlightedColor: .black)
//        bt.position.y = self.size.height - bt.size.height/2
//        bt.position.x = 3.5*bt.size.width/2
//
//        bt.addClosure(.touchUpInside, target: self, closure: { (currentScene, sender) -> () in
//            let scene = ShapesTestScene()
//            currentScene.view?.presentScene(scene, transition: TRANSITION_TO_GAME)
//        })
//        return bt
//        }()
//
//    lazy var endlessGameTest:TWButton = {
//        let bt = TWButton(size: CGSize(width: 40, height: 40), normalColor: .white, highlightedColor: .black)
//        bt.position.y = self.size.height - bt.size.height/2
//        bt.position.x = 1*bt.size.width/2
//
//        bt.addClosure(.touchUpInside, target: self, closure: { (currentScene, sender) -> () in
//            let scene = GameScene(isEndlessGame: true)
//            currentScene.view?.presentScene(scene, transition: TRANSITION_TO_GAME)
//        })
//        return bt
//    }()
//
//    #if SNAPSHOT
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        let scene = GameScene()
//        GameViewController.gameView.presentScene(scene, transition: TRANSITION_TO_GAME)
//    }
//    #endif
}
