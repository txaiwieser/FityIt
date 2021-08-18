//
//  AppDelegate.swift
//  FityIt
//
//  Created by Txai Wieser on 13/03/18.
//  Copyright © 2018 Txai Wieser. All rights reserved.
//

import SpriteKit
import TWSpriteKitUtils
import StoreKit

class InitialScene: SKScene {
    private var animationApear: (() -> Void)? = nil
    private var animationDisappear: (() -> Void)? = nil
    
    var gameScene: GameScene?
    private var score: Score?
    private var isInitialScene: Bool {
        get {
            return self.score == nil
        }
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        animationApear?()
        
        if gameScene == nil {
            AppCache.instance.initializeGameTextures(with: GameScene.calculateSceneSize(view.frame.size))
            gameScene = GameScene()
        }
        
        if AppPersistence.highScorePoints > 10 && AppPersistence.matchesPlayedSinceLaunch > 6 {
            SKStoreReviewController.requestReview()
        }
    }
    
    override func willMove(from view: SKView) {
        super.willMove(from: view)
        animationDisappear?()
    }
    
    init(score: Score?) {
        self.score = score
        let newSize = InitialScene.calculateSceneSize()
        super.init(size: newSize)
        GameCenter.shared.authenticateLocalUser()
        
        if let score = score { AppPersistence.saveNewScore(score) }
        
        backgroundColor = .black
        AppCache.instance.initializeInitialScreenBackgroundTexture(screenSize: newSize)
        
        let gradientNode1 = SKSpriteNode(texture: AppCache.instance.initialScreenBackgroundTexture)
        gradientNode1.position = CGPoint(x: newSize.width/2, y: newSize.height/2)
        gradientNode1.position.y += newSize.height/4
        gradientNode1.alpha = 1
        gradientNode1.zPosition = 1
        addChild(gradientNode1)
        
        let gradientNode2 = SKSpriteNode(color: .darkerBlack, size: CGSize(width: newSize.width, height: newSize.height/2))
        gradientNode2.position = CGPoint(x: newSize.width/2, y: newSize.height/2)
        gradientNode2.position.y -= newSize.height/4
        gradientNode2.alpha = 1
        gradientNode2.zPosition = 390
        addChild(gradientNode2)
        
        let isiPad = UIDevice.current.userInterfaceIdiom == .pad
        let spacing: CGFloat = isiPad ? 24 : 12
        
        let circlesStack = TWStackNode(
            fillMode: .horizontal,
            sizingMode: .dynamic(spacing: spacing),
            childNodes: [
                playButton,
                shareButton
            ]
        )
        
        let squaresStack = TWStackNode(
            fillMode: .horizontal,
            sizingMode: .dynamic(spacing: spacing),
            childNodes: [
                leaderboardButton,
                soundButton,
                rateButton
            ]
        )
        
        let bottomStack = TWStackNode(
            fillMode: .vertical,
            sizingMode: .dynamic(spacing: 2 * spacing),
            childNodes: [
                circlesStack,
                squaresStack
            ]
        )

        bottomStack.position = CGPoint(x: newSize.width/2, y: newSize.height / 4)
        bottomStack.zPosition = 1000
        addChild(bottomStack)
        
        let multiplier: CGFloat = isiPad ? 30 : 20
        scoreContainer.alpha = 0
        scoreContainer.setScore(self.score ?? Score(points: 0))
        
        let topStack = TWStackNode(
            fillMode: .vertical,
            sizingMode: .dynamic(spacing: nil)
        )
        topStack.size.width = newSize.width
        topStack.position = CGPoint(x: newSize.width/2, y: newSize.height/2)
        topStack.position.y += newSize.height/4 - multiplier/2
        topStack.zPosition = 400
        topStack.add(node: bannerLogo, reload: false)
        topStack.add(node: scoreContainer, reload: false)
        topStack.reloadStack()
        addChild(topStack)
        
        tutorialButton.position = CGPoint(
            x: newSize.width - 20,
            y: newSize.height - 40
        )
        tutorialButton.zPosition = 500
        tutorialButton.alpha = 0
        addChild(tutorialButton)
        
        let track = SKSpriteNode(color: .white, size: CGSize(width: newSize.width + 10, height: multiplier))
        track.position = CGPoint(x: newSize.width/2, y: newSize.height/2)
        track.position.y -= multiplier/2
        track.zPosition = 400
        addChild(track)
        
        animationApear = { [weak self] in
            if let strongSelf = self {
                let start1 = bottomStack.position - CGPoint(x: 0 , y: 2 * strongSelf.convert(.zero, from: bottomStack).y)
                let ef1 = SKTMoveEffect(node: bottomStack, duration: 0.8, startPosition: start1, endPosition: bottomStack.position)
                ef1.timingFunction = SKTTimingFunctionBounceEaseOut
                bottomStack.run(.actionWithEffect(ef1))
                
                let logo = strongSelf.bannerLogo
                let start2 = logo.position + CGPoint(x: 0, y: 2 * (strongSelf.size.height - strongSelf.convert(.zero, from: logo).y))
                let ef2 = SKTMoveEffect(node: logo, duration: 0.8, startPosition: start2, endPosition: logo.position)
                ef2.timingFunction = SKTTimingFunctionBounceEaseOut
                logo.run(.actionWithEffect(ef2))
                
                strongSelf.scoreContainer.run(.appearAnimated(strongSelf.scoreContainer, time: 0.9, scale: 1))
                strongSelf.tutorialButton.run(.appearAnimated(strongSelf.tutorialButton, time: 0.8, scale: 1))
            }
        }
        
        animationDisappear = { [weak self] in
            if let strongSelf = self {
                let end1 = bottomStack.position - CGPoint(x: 0 , y: 2 * strongSelf.convert(.zero, from: bottomStack).y)
                let ef1 = SKTMoveEffect(node: bottomStack, duration: 0.2, startPosition: bottomStack.position, endPosition: end1)
                ef1.timingFunction = SKTTimingFunctionExponentialEaseIn
                bottomStack.run(.actionWithEffect(ef1))
                
                let logo = strongSelf.bannerLogo
                let end2 = logo.position + CGPoint(x: 0, y: 2 * (strongSelf.size.height - strongSelf.convert(.zero, from: logo).y))
                let ef2 = SKTMoveEffect(node: logo, duration: 0.2, startPosition: logo.position, endPosition: end2)
                ef2.timingFunction = SKTTimingFunctionExponentialEaseIn
                logo.run(.actionWithEffect(ef2))
                
                strongSelf.scoreContainer.run(.disappearAnimated(strongSelf.scoreContainer, time: 0.3))
                strongSelf.tutorialButton.run(.disappearAnimated(strongSelf.tutorialButton, time: 0.16))
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func calculateSceneSize(_ size: CGSize? = nil) -> CGSize {
        return size ?? AppDelegate.gameViewController.gameView.frame.size
    }
    
    private func removeUIandPresentScene(_ scene:SKScene) {
        func present() {
            AppDelegate.gameViewController.gameView.presentScene(scene, transition: AppDefines.Transition.toGame)
        }
        
        if let animation = animationDisappear {
            animation()
            run(
                .afterDelay(0.36) {
                    present()
                }
            )
        } else {
            present()
        }
    }
    
    // MARK: Buttons and banners
    
    private lazy var bannerLogo: SKSpriteNode = SKSpriteNode(texture: AppCache.instance.interfaceAtlas.textureNamed("fityit_logo"))
    private lazy var scoreContainer: ScoreContainer = ScoreContainer(texture: AppCache.instance.interfaceAtlas.textureNamed("score_container"))
    
    private lazy var playButton: TWButton = {
        let bt = TWButton(
            normal: AppCache.instance.interfaceAtlas.textureNamed("bt_play_n"),
            highlighted: AppCache.instance.interfaceAtlas.textureNamed("bt_play_h")
        )
        
        bt.addClosure(.touchUpInside) { [unowned self] _ in
            let scene = gameScene ?? GameScene()
            removeUIandPresentScene(scene)
        }
        return bt
    }()
    
    private lazy var tutorialButton: TWButton = {
        let normalLabel = SKLabelNode(text: "?")
        normalLabel.fontName = AppDefines.FontName.defaultLight
        normalLabel.fontSize = 30
        normalLabel.fontColor = .white
        
        let highlightedLabel = SKLabelNode(text: "?")
        highlightedLabel.fontName = AppDefines.FontName.defaultLight
        highlightedLabel.fontSize = 30
        highlightedLabel.fontColor = .white.withAlphaComponent(0.7)
        
        let bt = TWButton(normal: normalLabel, highlighted: highlightedLabel)
        
        bt.addClosure(.touchUpInside) { [unowned self] _ in
            AppPersistence.alreadyPlayTutorial = false
            removeUIandPresentScene(GameScene())
        }
        return bt
    }()
    
    private lazy var leaderboardButton: TWButton = {
        let bt = TWButton(
            normal: AppCache.instance.interfaceAtlas.textureNamed("bt_leaderboard_n"),
            highlighted: AppCache.instance.interfaceAtlas.textureNamed("bt_leaderboard_h")
        )
        
        bt.addClosure(.touchUpInside) { _ in
            GameCenter.shared.showGameCenter(AppDelegate.gameViewController, viewState: .leaderboards)
        }
        return bt
    }()
    
    private lazy var shareButton: TWButton = {
        let bt = TWButton(
            normal: AppCache.instance.interfaceAtlas.textureNamed("bt_share_n"),
            highlighted: AppCache.instance.interfaceAtlas.textureNamed("bt_share_h")
        )
        
        bt.addClosure(.touchUpInside) { [unowned self] _ in
            var objectsToShare: [Any] = []
            
            if let score = score {
                let pointsMessage = (score.points == 1 ? "SHARE_MESSAGE_COMPLETE_POINT" : "SHARE_MESSAGE_COMPLETE_POINTS")
                let textToShare = String(format:NSLocalizedString("SHARE_MESSAGE_COMPLETE", comment: ""), score.points, NSLocalizedString(pointsMessage, comment: ""), score.highScorePoints())
                objectsToShare.append(textToShare)
            } else {
                let textToShare = String(format:NSLocalizedString("SHARE_MESSAGE_TOP", comment: "message send when shared"), AppPersistence.highScorePoints)
                objectsToShare.append(textToShare)
            }
            
            let shareImageSize = CGSize(width: 600, height: 400)
            let shareImageView = SKView(frame: CGRect(origin: .zero, size: shareImageSize))
            
            let shareImageOverlayView = UIImageView(image: UIImage(named: "bg1"))
            shareImageOverlayView.frame = shareImageView.frame
            shareImageOverlayView.contentMode = .scaleAspectFill
            shareImageOverlayView.isUserInteractionEnabled = false
            shareImageOverlayView.alpha = 0.16
            shareImageView.addSubview(shareImageOverlayView)
            
            let shareImageScene = ShareImageScene(size: shareImageSize, score: score)
            shareImageView.presentScene(shareImageScene)
            if let shareImage = shareImageView.asImage(.current) {
                objectsToShare.append(shareImage)
            }
            
            objectsToShare.append(AppDefines.Constants.appStoreLink)
            
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            let gameView = AppDelegate.gameViewController.gameView
            activityVC.popoverPresentationController?.sourceView = gameView
            activityVC.popoverPresentationController?.sourceRect = CGRect(origin: CGPoint(x: gameView.frame.size.width/2, y: gameView.frame.size.height/2), size: .zero)
            activityVC.popoverPresentationController?.permittedArrowDirections = .up
            
            AppDelegate.gameViewController.present(activityVC, animated: true, completion: nil)
        }
        return bt
    }()
    
    private lazy var rateButton: TWButton = {
        let bt = TWButton(
            normal: AppCache.instance.interfaceAtlas.textureNamed("bt_rate_n"),
            highlighted: AppCache.instance.interfaceAtlas.textureNamed("bt_rate_h")
        )
        
        bt.addClosure(.touchUpInside) { _ in
            let alert = UIAlertController(title: NSLocalizedString("RATE_ALERT_TITLE", comment: ""), message: NSLocalizedString("RATE_ALERT_MESSAGE", comment: ""), preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: NSLocalizedString("RATE_ALERT_YES", comment: ""), style: .default, handler: { (action:UIAlertAction) -> Void in
                
                let appID = AppDefines.Constants.appStoreID
                let rateURLString = "itms-apps://itunes.apple.com/us/app/\(appID)?action=write-review"

                if let url = URL(string: rateURLString) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }))
            
            alert.addAction(UIAlertAction(title: NSLocalizedString("RATE_ALERT_CANCEL", comment: ""), style: .cancel, handler: nil))
            AppDelegate.gameViewController.present(alert, animated: true, completion: nil)
        }
        return bt
    }()
    
    private lazy var soundButton: TWSwitch = {
        let sw = TWSwitch(
            normal: AppCache.instance.interfaceAtlas.textureNamed("bt_sound_on_n"),
            highlighted: (
                fromNormal: AppCache.instance.interfaceAtlas.textureNamed("bt_sound_on_h"),
                fromSelected: AppCache.instance.interfaceAtlas.textureNamed("bt_sound_off_h")
            ),
            selected: AppCache.instance.interfaceAtlas.textureNamed("bt_sound_off_n")
        )
        
        sw.state.isSelected = !SKAction.shouldPlaySound()
        sw.addClosure(.touchUpInside) { sender in
            SKAction.saveNewSoundEffectsSettings(!sender.state.isSelected)
        }
        return sw
    }()
    
    #if SNAPSHOT
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let scene = gameScene ?? GameScene()
        AppDelegate.gameViewController.gameView.presentScene(scene, transition: AppDefines.Transition.toGame)
    }
    #endif
}
