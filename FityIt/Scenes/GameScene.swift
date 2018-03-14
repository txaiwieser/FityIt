//
//  GameScene.swift
//  FityIt
//
//  Created by Txai Wieser on 13/03/18.
//  Copyright © 2018 Txai Wieser. All rights reserved.
//

import SpriteKit
//import TWSpriteKitUtils

class GameScene: SKScene, SKPhysicsContactDelegate {
    var updateTimer = UpdateTimer()
//    let spinner = Spinner()
//    let scoreBoard = ScoreBoard()
//    let IS_ENDLESS_GAME:Bool
//    let ZPOS_SHAPE = CGFloat(1000+2)
//    let ZPOS_SPINNER = CGFloat(1000)
//    let ZPOS_ABOVE_IT_ALL = CGFloat(10_000)
//
//    lazy var yStartPosition:CGFloat = self.size.height/2 - Shape.defaultSize.height
//    lazy var yEndPosition:CGFloat = -self.size.height/2 + self.spinner.rectLenght
//
//    let rightArrow = GesturesAnimation(right: true, radius: 80)
//    let leftArrow = GesturesAnimation(right: false, radius: 80)
//    let gameSceneNodeContainer:SKNode = SKNode()
//    var gradientNode:SKSpriteNode!
//
//    init(isEndlessGame:Bool = false) {
//        Shape.lastRandomShapeIndex = 0
//        IS_ENDLESS_GAME = isEndlessGame
//        let newSize = GameScene.calculateSceneSize()
//        super.init(size: newSize)
//        self.scaleMode = .aspectFill
//        gameSceneNodeContainer.position = CGPoint(size: newSize/2)
//        super.addChild(gameSceneNodeContainer)
//
//        GameSingleton.instance.initializeGameTextures(newSize)
//        backgroundColor = SKColor.black
//
//        GameSingleton.instance.backgroundCrops?.forEach { if $0.1.parent == nil { self.addChildToContainer($0.1) } }
//
//        gradientNode = SKSpriteNode(texture: GameSingleton.instance.gradient("Circle"), size: newSize)
//        gradientNode.alpha = 1
//        gradientNode.zPosition = 1
//        addChildToContainer(gradientNode)
//
//
//        physicsWorld.gravity = CGVector.zero
//        physicsWorld.contactDelegate = self
//
//        let margin = CGFloat(46)
//        leftArrow.position.x = -newSize.width/2 + margin
//        leftArrow.zPosition = ZPOS_SHAPE
//        leftArrow.position.y = -36
//        addChildToContainer(leftArrow)
//
//        rightArrow.position.x = newSize.width/2 - margin
//        rightArrow.zPosition = ZPOS_SHAPE
//        rightArrow.position.y = -36
//        addChildToContainer(rightArrow)
//
//        spinner.zPosition = ZPOS_SPINNER
//        spinner.position.y = -newSize.height/2 - 75
//        addChildToContainer(spinner)
//
//        scoreBoard.zPosition = ZPOS_SHAPE - 10
//        scoreBoard.position.y = 124
//        addChildToContainer(scoreBoard)
//
//        if isEndlessGame {
//            addChildToContainer(backToInitial)
//        }
//
//        if PersistenceHandler.alreadyPlayTutorial == true {
//            scoreBoard.letsGo() { [weak self] in
//                self?.gameStarted = true
//            }
//        } else {
//            PersistenceHandler.alreadyPlayTutorial = true
//            gameStarted = false
//            scoreBoard.tapTutorial()
//            leftArrow.repeatTapEvery()
//            isWaitingForLeft = true
//        }
//
//        animationApear = {  [weak self] in
//            if let selfie = self {
//                                var start = CGPoint(x: 0, y: selfie.spinner.position.y - selfie.spinner.size.height)
//                //            let ef1 = SKTMoveEffect(node: selfie.spinner, duration: 0.8, startPosition: start, endPosition: selfie.spinner.position)
//                //            ef1.timingFunction = SKTTimingFunctionBounceEaseOut
//                //            selfie.spinner.runAction(SKAction.actionWithEffect(ef1))
//
//                start = selfie.leftArrow.position - CGPoint(x: 2*(selfie.size.width/2 + selfie.leftArrow.position.x), y: 0)
//                let ef2 = SKTMoveEffect(node: selfie.leftArrow, duration: 0.8, startPosition: start, endPosition: selfie.leftArrow.position)
//                ef2.timingFunction = SKTTimingFunctionBounceEaseOut
//                selfie.leftArrow.run(SKAction.actionWithEffect(ef2))
//
//                start = selfie.rightArrow.position + CGPoint(x: 2*(selfie.size.width/2 - selfie.rightArrow.position.x), y: 0)
//                let ef3 = SKTMoveEffect(node: selfie.rightArrow, duration: 0.8, startPosition: start, endPosition: selfie.rightArrow.position)
//                ef3.timingFunction = SKTTimingFunctionBounceEaseOut
//                selfie.rightArrow.run(SKAction.actionWithEffect(ef3))
//
//
//                selfie.spinner.run(SKAction.apearAnimated(selfie.spinner, time: 0.9, scale: 1))
//                selfie.scoreBoard.run(SKAction.apearAnimated(selfie.scoreBoard, time: 0.9, scale: 1))
//            }
//        }
//
//        animationDisapear = { [weak self] in
//            if let selfie = self {
//
//                var end: CGPoint = CGPoint(x: 0, y: selfie.spinner.position.y - selfie.spinner.size.height)
//
//                let ef1 = SKTMoveEffect(node: selfie.spinner, duration: 0.2, startPosition: selfie.spinner.position, endPosition: end)
//                ef1.timingFunction = SKTTimingFunctionExponentialEaseIn
//                selfie.spinner.run(SKAction.actionWithEffect(ef1))
//
//                end = selfie.leftArrow.position - CGPoint(x: 2*(selfie.size.width/2 + selfie.leftArrow.position.x), y: 0)
//                let ef2 = SKTMoveEffect(node: selfie.leftArrow, duration: 0.8, startPosition: selfie.leftArrow.position, endPosition: end)
//                ef2.timingFunction = SKTTimingFunctionBounceEaseOut
//                selfie.leftArrow.run(SKAction.actionWithEffect(ef2))
//
//                end = selfie.rightArrow.position + CGPoint(x: 2*(selfie.size.width/2 - selfie.rightArrow.position.x), y: 0)
//                let ef3 = SKTMoveEffect(node: selfie.rightArrow, duration: 0.8, startPosition: selfie.rightArrow.position, endPosition: end)
//                ef3.timingFunction = SKTTimingFunctionBounceEaseOut
//                selfie.rightArrow.run(SKAction.actionWithEffect(ef3))
//
//                //            selfie.spinner.runAction(SKAction.disapearAnimated(selfie.spinner, time: 0.3))
//
//
//                //            selfie.tutorialButton.runAction(SKAction.disapearAnimated(selfie.tutorialButton, time: 0.16))
//            }
//        }
//    }
//    var animationApear: (()->Void)? = nil
//    var animationDisapear: (()->Void)? = nil
//
//
//    func removeUIandPresentScene(_ scene:SKScene, ad:Bool) {
//        func present(_ ad:Bool) {
//            if ad {
//                GameViewController.instance.gameEndedPresentAdAndInitialScene(scene)
//            } else {
//                GameViewController.gameView.presentScene(scene, transition: TRANSITION_TO_INITIAL)
//            }
//        }
//        if let anim = animationDisapear {
//            anim()
//            afterDelay(0.36) { present(ad) }
//        } else {
//            present(ad)
//        }
//    }
//
//
//    override func didMove(to view: SKView) {
//        super.didMove(to: view)
//        animationApear?()
//
//        afterDelay(0.8) {
//            GameSingleton.instance.backgroundCrops?.forEach { $0.1.removeFromParent() }
//        }
//    }
//
//    func addChildToContainer(_ node: SKNode) {
//        gameSceneNodeContainer.addChild(node)
//    }
//
//    lazy var backToInitial:TWButton = {
//        let bt = TWButton(size: CGSize(width: 50, height: 50), normalColor: .red, highlightedColor: .white)
//        bt.position = CGPoint(x: -self.size.width/2 + bt.size.height/2, y: self.size.height/2 - bt.size.height/2)
//        bt.zPosition = 500
//        bt.addClosure(.touchUpInside, target: self, closure: { (currentScene, sender) -> () in
//            let scene = InitialScene(score: nil)
//            currentScene.removeUIandPresentScene(scene, ad: false)
//        })
//
//        return bt
//    }()
//
//    override func addChild(_ node: SKNode) {
//        assertionFailure("Error: Use addChildToContainer instead of addChild!")
//    }
//    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
//    deinit { print("->          AAAAA: MAIN LOG: Game Scene released!") }
//
//    func didBegin(_ contact: SKPhysicsContact) {
//        let a = contact.bodyA
//        let b = contact.bodyB
//
//        let nodoAehUmaFormaGeometrica = (a.categoryBitMask & PhysicsCategory.allShapes()) > 0
//        let nodoBehUmaFormaGeometrica = (b.categoryBitMask & PhysicsCategory.allShapes()) > 0
//
//        if nodoAehUmaFormaGeometrica && nodoBehUmaFormaGeometrica {
//            let saoDoMesmoTipo = a.categoryBitMask == b.categoryBitMask
//            if saoDoMesmoTipo {
//                if let sh = a.node as? Shape, let sp = b.node as? SpinnerPart { resolveCollisionBetween(spinnerPart:sp, shape: sh) }
//                else if let sh = b.node as? Shape, let sp = a.node as? SpinnerPart { resolveCollisionBetween(spinnerPart:sp, shape: sh) }
//            } else {
//                if let sh = a.node as? Shape, let _ = b.node as? SpinnerPart { wrongCollision(sh) }
//                else if let sh = b.node as? Shape, let _ = a.node as? SpinnerPart { wrongCollision(sh) }
//            }
//        }
//    }
//
//    func wrongCollision(_ shape:Shape) {
//        scoreBoard.failed()
//        if IS_ENDLESS_GAME {
//            shape.failure()
//        } else {
//            gameEnded = true
//            shape.failure() { [weak self] in
//                self?.gameShouldEnd()
//            }
//        }
//        failureEffect(shape.failureDuration, lastShapeName: shape.shapeName)
//
//    }
//
//    func resolveCollisionBetween(spinnerPart:SpinnerPart, shape:Shape) {
//        if shape.actived {
//            if mh.positionIsOnRange(convert(shape.position, from: shape.parent!), point: convert(spinnerPart.dockingPosition, from: spinnerPart), range: 16) {
//
//                shape.position = spinner.convert(shape.position, from: shape.parent!)
//                shape.zRotation -= spinner.zRotation
//                shape.zPosition = 5
//                shape.removeAction(forKey: Shape.MOVE_ACTION)
//                shape.removeFromParent()
//
//                spinner.addChild(shape)
//                let num = scoreBoard.points+1
//                let tenMultiples = ((num%10) == 0)
//                let notZero = (num != 0)
//                shape.success(tenMultiples && notZero)
//
//                let effect = SKTMoveEffect(node: shape, duration: shape.disappearDuration, startPosition: shape.position, endPosition: CGPoint.zero)
//                effect.timingFunction = SKTTimingFunctionLinear
//
//                let ac = SKAction.actionWithEffect(effect)
//                if shape.waitToDisappearDuration > 0 {
//                    shape.run(SKAction.afterDelay(shape.waitToDisappearDuration, performAction: ac), withKey: Shape.MOVE_ACTION)
//                } else {
//                    shape.run(ac, withKey: Shape.MOVE_ACTION)
//                }
//
//                scoreBoard.add1()
//                successEffect(shape.disappearDuration + shape.creationDuration/2, gradientName: shape.shapeName)
//
//            } else {
//                shape.countToExplode()
//            }
//        }
//    }
//
//    func failureEffect(_ duration:TimeInterval, lastShapeName:String) {
//        let shake = SKAction.screenShakeWithNode(gameSceneNodeContainer, amount: CGPoint(x: 50, y: 10), oscillations: 4, duration: duration)
//        let rot = SKAction.screenRotateWithNode(gameSceneNodeContainer, angle: CGFloat(M_PI)/16, oscillations: 3, duration: duration)
//        gameSceneNodeContainer.run(SKAction.group([shake, rot]))
//
//        let glitch = SKAction.textureGlitch(lastShapeName, duration: duration/4, availableTextures: availableShapesNames)
//        gradientNode.run(glitch)
//    }
//
//
//    func successEffect(_ duration:TimeInterval, gradientName:String) {
//
//        func applyDefaultTexture() {
//            gradientNode.setTexture(GameSingleton.instance.gradient(gradientName), byCroppingWith: GameSingleton.instance.backgroundCrop(gradientName), duration: duration)
//
//        }
//
//        func applySimpleTexture() {
//            gradientNode.setTexture(GameSingleton.instance.gradient(gradientName), duration: duration)
//        }
//
//        if #available(iOS 9.2, *) {
//            applyDefaultTexture()
//        } else {
//            if #available(iOS 9.0, *) {
//                applySimpleTexture()
//            } else {
//                applyDefaultTexture()
//            }
//        }
//
//        let shake = SKAction.screenShakeWithNode(gameSceneNodeContainer, amount: CGPoint(x: 0, y: -36), oscillations: 2, duration: duration + 0.05)
//        gameSceneNodeContainer.run(shake)
//    }
//
//    func gameShouldEnd() {
//        if !gameEndedDoOnce {
//            gameEndedDoOnce = true
//            PersistenceHandler.newPlayedMatch()
//            removeUIandPresentScene(InitialScene(score: scoreBoard.getScore()), ad: true)
//        }
//    }
//
//    func releaseShape() {
//        let node = Shape.randomShape()
//        node.position.y = yStartPosition
//        node.zPosition = ZPOS_SHAPE
//        addChildToContainer(node)
//
//        let moveDiv:TimeInterval = 0.6
//        let creationDiv:TimeInterval = (1-moveDiv) * 0.6
//        let disappearDiv:TimeInterval = (1 - moveDiv - creationDiv) * 0.9
//        let waitToDisapearDiv:TimeInterval = 1 - moveDiv - creationDiv - disappearDiv
//
//        let delay = delayBetweenLaunches(scoreBoard.points)
//
//        node.moveDuration = moveDiv*delay
//        node.creationDuration = creationDiv*delay
//        node.disappearDuration = disappearDiv*delay
//        node.waitToDisappearDuration = waitToDisapearDiv*delay
//
//
//        node.create() { [weak self] in
//            self?.scoreBoard.removeScoreLabel()
//            node.activatePhysicsBody()
//            node.releaseMe()
//        }
//        if releaseSounds != nil { run(releaseSound()) }
//    }
//
//
//
    static func calculateSceneSize(_ size: CGSize? = nil) -> CGSize {
        let size = size ?? AppDelegate.gameViewController.gameView.frame.size
        let defaultHeight: CGFloat = 736
        let const = defaultHeight / size.height
        return CGSize(width: const * size.width, height: defaultHeight)
    }
//
//
//    #if SNAPSHOT
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//
//        if let c = gameSceneNodeContainer.childNodeWithName("sn_circle") as? Shape {
//            // Prepare for SNAPSHOT 2
//            scoreBoard.removeScoreLabel()
//            c.removeFromParent()
//            gradientNode.setTexture(GameSingleton.instance.gradient(c.shapeName), byCroppingWith: GameSingleton.instance.backgroundCrop(c.shapeName), duration: 0.1)
//            let cc = Square()
//            cc.creationDuration = 0.1
//            cc.create()
//            cc.name = "sn_square"
//            cc.position.y = yStartPosition - (yStartPosition + abs(yEndPosition))*(1/3)
//            cc.zPosition = ZPOS_SHAPE
//            addChildToContainer(cc)
//            spinner.spinn(false, delay: 0.1)
//        } else if let c = gameSceneNodeContainer.childNodeWithName("sn_square") as? Shape {
//            // Prepare for SNAPSHOT 3
//            c.removeFromParent()
//            gradientNode.setTexture(GameSingleton.instance.gradient(c.shapeName), byCroppingWith: GameSingleton.instance.backgroundCrop(c.shapeName), duration: 0.1)
//            scoreBoard.removeAllActions()
//            scoreBoard.tapTutorial()
//            leftArrow.addMarker()
//            rightArrow.addMarker()
//            let cc = Triangle()
//            cc.creationDuration = 0.1
//            cc.name = "sn_triangle"
//            cc.create()
//            cc.position.y = yStartPosition - (yStartPosition + abs(yEndPosition))*(2/3)
//            cc.zPosition = ZPOS_SHAPE
//            addChildToContainer(cc)
//            spinner.spinn(false, delay: 0.1)
//        } else if let c = gameSceneNodeContainer.childNodeWithName("sn_triangle") as? Shape {
//            // Prepare for SNAPSHOT 4
//            c.removeFromParent()
//            gradientNode.setTexture(GameSingleton.instance.gradient(c.shapeName), byCroppingWith: GameSingleton.instance.backgroundCrop(c.shapeName), duration: 0.1)
//            leftArrow.stopAnimating()
//            rightArrow.stopAnimating()
//            scoreBoard.TESTdisplayNumber(14)
//            let cc = Pentagon()
//            cc.creationDuration = 0.1
//            cc.create()
//            cc.name = "sn_pentagon"
//            cc.position.y = yEndPosition
//            cc.zPosition = ZPOS_SHAPE
//            addChildToContainer(cc)
//        } else if let c = gameSceneNodeContainer.childNodeWithName("sn_pentagon") as? Shape {
//            // CLEANING
//            c.removeFromParent()
//            scoreBoard.removeScoreLabel()
//        } else {
//            // Prepare for SNAPSHOT 1
//            let c = Pentagon()
//            gradientNode.setTexture(GameSingleton.instance.gradient(c.shapeName), byCroppingWith: GameSingleton.instance.backgroundCrop(c.shapeName), duration: 0.1)
//            let cc = Circle()
//            cc.creationDuration = 0.1
//            cc.create()
//            cc.name = "sn_circle"
//            cc.position.y = yStartPosition
//            cc.zPosition = ZPOS_SHAPE
//            addChildToContainer(cc)
//            spinner.spinn(true, delay: 0.1)
////            leftArrow.stopAnimating()
////            rightArrow.stopAnimating()
//            scoreBoard.removeAllActions()
//            scoreBoard.letsGo(8, completion: {})
//
//        }
//    }
//    #else
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        /* Called when a touch begins */
//        super.touchesBegan(touches, with: event)
//        for touch: AnyObject in touches {
//
//            let location = touch.location(in: self)
//            actionRecognized(location.x >= size.width/2 ? true : false)
//        }
//    }
//
//    func actionRecognized(_ right: Bool) {
//        if gameStarted {
//            let d = spinnerDelay(scoreBoard.points)
//            if right {
//                rightArrow.tap()
//                spinner.spinn(true, delay: d)
//                isWaitingForRight = false
//            } else {
//                leftArrow.tap()
//                spinner.spinn(false, delay: d)
//                isWaitingForLeft = false
//            }
//        } else {
//            if right {
//                if isWaitingForRight {
//                    rightArrow.tap()
//                    spinner.spinn(true)
//                    isWaitingForRight = false
//                }
//            } else {
//                if isWaitingForLeft {
//                    leftArrow.tap()
//                    spinner.spinn(false)
//                    isWaitingForLeft = false
//                }
//            }
//        }
//    }
//
//    override func update(_ currentTime: TimeInterval) {
//        /* Called before each frame is rendered */
//
//        updateTimer.update(currentTime)
//
//        let t = delayBetweenLaunches(scoreBoard.points)
//        if (updateTimer.timeSinceLastLap >= t || firstShape) && !gameEnded && gameStarted {
//            self.releaseShape()
//            updateTimer.lap()
//            firstShape = false
//        }
//    }
//    #endif
//
//
//    var firstShape:Bool = true
//    var gameEndedDoOnce = false
//    var gameEnded:Bool = false
//    var gameStarted:Bool = false
//    var tapCounter = false
//    var isWaitingForLeft = false {
//        didSet {
//            if oldValue == true && isWaitingForLeft == false {
//                if tapCounter {
//                    tapCounter = false
//                    leftArrow.stopAnimating()
//                    rightArrow.repeatTapEvery()
//                    isWaitingForRight = true
//                } else {
//                    tapCounter = true
//                    isWaitingForLeft = true
//                }
//            }
//        }
//    }
//
//    var isWaitingForRight = false {
//        didSet {
//            if oldValue == true && isWaitingForRight == false {
//                if tapCounter {
//                    tapCounter = false
//                    rightArrow.stopAnimating()
//                    scoreBoard.letsGo() { [weak self] in
//                        self?.gameStarted = true
//                    }
//                } else {
//                    tapCounter = true
//                    isWaitingForRight = true
//                }
//            }
//        }
//    }
//
//    override func didSimulatePhysics() {
//        for n in self.children {
//            if let nn = n as? Shape {
//                nn.position.x = size.width/2
//            }
//        }
//    }
//
//
//    let releaseSounds:[SKAction]? = {
//        return nil
//    }()
//    var soundCounter = 0
//    var up = true
//
//    func releaseSound() -> SKAction {
//        let sounds = releaseSounds!
//        if up {
//            if soundCounter < sounds.count-1 {
//                soundCounter += 1
//                return sounds[soundCounter]
//            } else {
//                up = false
//                soundCounter -= 1
//                return sounds[soundCounter]
//            }
//        } else {
//            if soundCounter > 0 {
//                soundCounter -= 1
//                return sounds[soundCounter]
//            } else {
//                up = true
//                soundCounter += 1
//                return sounds[soundCounter]
//            }
//        }
//    }
//
//    // MARK: GAME TIMING FUNCTIONS
//
//    let minDelayBetweenLaunches = Double(1.4)
//    let maxDelayBetweenLaunches = Double(3)
//
//    let minSpinnerDelay = Double(0.12)
//    let maxSpinnerDelay = Double(0.2)
//
//
//    func delayBetweenLaunches(_ points:Int) -> Double {
//        let x = Double(points)
//        let y: Double = pow(0.971, x) + sin(x/2)*0.02 + 0.02
//        return y.relative(min: minDelayBetweenLaunches, max: maxDelayBetweenLaunches)
//    }
//
//    func spinnerDelay(_ points:Int) -> Double {
//        let x = Double(points)
//        let y: Double = pow(0.98, x)
//        return y.relative(min: minSpinnerDelay, max: maxSpinnerDelay)
//    }
}
