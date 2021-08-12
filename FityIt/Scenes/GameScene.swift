//
//  GameScene.swift
//  FityIt
//
//  Created by Txai Wieser on 13/03/18.
//  Copyright © 2018 Txai Wieser. All rights reserved.
//

import SpriteKit
import TWSpriteKitUtils

class GameScene: SKScene, SKPhysicsContactDelegate {
    var updateTimer = UpdateTimer()
    private let spinner = Spinner()
    private let scoreBoard = GameScoreHUD()
    let isEndlessGame: Bool

    private let rightArrow = GameGesturesHUD(right: true, radius: 80)
    private let leftArrow = GameGesturesHUD(right: false, radius: 80)
    private let gameSceneNodeContainer = SKNode()
    private let gradientNode: SKSpriteNode
    
    private var animationApear: (() -> Void)? = nil
    private var animationDisappear: (() -> Void)? = nil
    
    private var firstShape:Bool = true
    private var gameEndedDoOnce = false
    private var gameEnded:Bool = false
    private var gameStarted:Bool = false
    private var tapCounter = false
    private var isWaitingForLeft = false {
        didSet {
            if oldValue == true && isWaitingForLeft == false {
                if tapCounter {
                    tapCounter = false
                    leftArrow.stopAnimating()
                    rightArrow.repeatTapEvery()
                    isWaitingForRight = true
                } else {
                    tapCounter = true
                    isWaitingForLeft = true
                }
            }
        }
    }
    private var isWaitingForRight = false {
        didSet {
            if oldValue == true && isWaitingForRight == false {
                if tapCounter {
                    tapCounter = false
                    rightArrow.stopAnimating()
                    scoreBoard.letsGo() { [weak self] in
                        self?.gameStarted = true
                    }
                } else {
                    tapCounter = true
                    isWaitingForRight = true
                }
            }
        }
    }

    private var shapeStartPositionY: CGFloat {
        return size.height / 2 - Shape.defaultSize.height - 8 - (AppDefines.Constants.isiPhoneX ? 30 : 0)
    }

    private var shapeEndPositionY: CGFloat {
        return -size.height / 2 + spinner.frameSide
    }

    private enum Constant {
        static let zPosShape: CGFloat = 1000 + 2
        static let zPosSpinner: CGFloat = 1000
        static let zPosAboveItAll: CGFloat = 10_000
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    init(isEndlessGame: Bool = false) {
        ShapeType.lastRandomShapeType = nil
        let newSize = GameScene.calculateSceneSize()
        self.isEndlessGame = isEndlessGame
        self.gradientNode = SKSpriteNode(texture: AppCache.instance.gradient(shape: .circle), size: newSize)
        super.init(size: newSize)
        scaleMode = .aspectFill
        backgroundColor = .black
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        gameSceneNodeContainer.position = CGPoint(x: newSize.width/2, y: newSize.height/2)
        super.addChild(gameSceneNodeContainer)

        AppCache.instance.backgroundCrops?.forEach { if $0.value.parent == nil { self.addChildToContainer($0.value) } }
        
        gradientNode.alpha = 1
        gradientNode.zPosition = 1
        addChildToContainer(gradientNode)

    
        let margin: CGFloat = 46
        leftArrow.position.x = -newSize.width / 2 + margin
        leftArrow.zPosition = Constant.zPosShape
        leftArrow.position.y = -36
        addChildToContainer(leftArrow)

        rightArrow.position.x = newSize.width / 2 - margin
        rightArrow.zPosition = Constant.zPosShape
        rightArrow.position.y = -36
        addChildToContainer(rightArrow)

        spinner.zPosition = Constant.zPosSpinner
        spinner.position.y = -newSize.height / 2 - 75
        addChildToContainer(spinner)

        scoreBoard.zPosition = Constant.zPosShape - 10
        scoreBoard.position.y = 124
        addChildToContainer(scoreBoard)

        if isEndlessGame {
            addChildToContainer(backToInitial)
        }

        if AppPersistence.alreadyPlayTutorial == true {
            scoreBoard.letsGo() { [weak self] in
                self?.gameStarted = true
            }
        } else {
            AppPersistence.alreadyPlayTutorial = true
            gameStarted = false
            scoreBoard.tapTutorial()
            leftArrow.repeatTapEvery()
            isWaitingForLeft = true
        }

        animationApear = {  [weak self] in
            if let strongSelf = self {
                var start = CGPoint(x: 0, y: strongSelf.spinner.position.y - strongSelf.spinner.size.height)

                start = strongSelf.leftArrow.position - CGPoint(x: 2 * strongSelf.size.width / 2 + strongSelf.leftArrow.position.x, y: 0)
                let ef2 = SKTMoveEffect(node: strongSelf.leftArrow, duration: 0.8, startPosition: start, endPosition: strongSelf.leftArrow.position)
                ef2.timingFunction = SKTTimingFunctionBounceEaseOut
                strongSelf.leftArrow.run(.actionWithEffect(ef2))

                start = strongSelf.rightArrow.position + CGPoint(x: 2*(strongSelf.size.width/2 - strongSelf.rightArrow.position.x), y: 0)
                let ef3 = SKTMoveEffect(node: strongSelf.rightArrow, duration: 0.8, startPosition: start, endPosition: strongSelf.rightArrow.position)
                ef3.timingFunction = SKTTimingFunctionBounceEaseOut
                strongSelf.rightArrow.run(.actionWithEffect(ef3))

                strongSelf.spinner.run(.appearAnimated(strongSelf.spinner, time: 0.9, scale: 1))
                strongSelf.scoreBoard.run(.appearAnimated(strongSelf.scoreBoard, time: 0.9, scale: 1))
            }
        }

        animationDisappear = { [weak self] in
            if let strongSelf = self {
                var end: CGPoint = CGPoint(x: 0, y: strongSelf.spinner.position.y - strongSelf.spinner.size.height)

                let ef1 = SKTMoveEffect(node: strongSelf.spinner, duration: 0.2, startPosition: strongSelf.spinner.position, endPosition: end)
                ef1.timingFunction = SKTTimingFunctionExponentialEaseIn
                strongSelf.spinner.run(.actionWithEffect(ef1))

                end = strongSelf.leftArrow.position - CGPoint(x: 2 * strongSelf.size.width / 2 + strongSelf.leftArrow.position.x, y: 0)
                let ef2 = SKTMoveEffect(node: strongSelf.leftArrow, duration: 0.8, startPosition: strongSelf.leftArrow.position, endPosition: end)
                ef2.timingFunction = SKTTimingFunctionBounceEaseOut
                strongSelf.leftArrow.run(.actionWithEffect(ef2))

                end = strongSelf.rightArrow.position + CGPoint(x: 2 * strongSelf.size.width / 2 - strongSelf.rightArrow.position.x, y: 0)
                let ef3 = SKTMoveEffect(node: strongSelf.rightArrow, duration: 0.8, startPosition: strongSelf.rightArrow.position, endPosition: end)
                ef3.timingFunction = SKTTimingFunctionBounceEaseOut
                strongSelf.rightArrow.run(.actionWithEffect(ef3))
                
                /*
                strongSelf.spinner.runAction(.disappearAnimated(strongSelf.spinner, time: 0.3))
                strongSelf.tutorialButton.runAction(.disappearAnimated(strongSelf.tutorialButton, time: 0.16))
                 */
            }
        }
    }

    private func removeUIandPresentScene(_ scene: SKScene) {
        func present() {
            AppDelegate.gameViewController.gameView.presentScene(scene, transition: AppDefines.Transition.toInitial)
        }
        
        if let anim = animationDisappear {
            anim()
            run(
                .afterDelay(0.36) {
                    present()
                }
            )
        } else {
            present()
        }
    }

    override func didMove(to view: SKView) {
        super.didMove(to: view)
        animationApear?()

        run(
            .afterDelay(0.8) {
                AppCache.instance.backgroundCrops?.forEach { $0.1.removeFromParent() }
            }
        )
    }

    private func addChildToContainer(_ node: SKNode) {
        gameSceneNodeContainer.addChild(node)
    }

    private lazy var backToInitial: TWButton = {
        let bt = TWButton(size: CGSize(width: 50, height: 50), normalColor: .red, highlightedColor: .white)
        bt.position = CGPoint(x: -self.size.width/2 + bt.size.height/2, y: self.size.height/2 - bt.size.height/2)
        bt.zPosition = 500
        bt.addClosure(.touchUpInside, target: self, closure: { (currentScene, sender) -> () in
            let scene = InitialScene(score: nil)
            currentScene.removeUIandPresentScene(scene)
        })

        return bt
    }()
    
    override func addChild(_ node: SKNode) {
        assertionFailure("Error: Use addChildToContainer instead of addChild!")
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let a = contact.bodyA
        let b = contact.bodyB
        
        let nodeAisAShape = (a.categoryBitMask & PhysicsCategory.allShapes) > 0
        let nodeBisAShape = (b.categoryBitMask & PhysicsCategory.allShapes) > 0
        
        if nodeAisAShape && nodeBisAShape {
            if a.categoryBitMask == b.categoryBitMask {
                if let sh = a.node as? Shape, let sp = b.node as? SpinnerPart { resolveCollision(between: sp, and: sh) }
                else if let sh = b.node as? Shape, let sp = a.node as? SpinnerPart { resolveCollision(between: sp, and: sh) }
            } else {
                if let sh = a.node as? Shape, let _ = b.node as? SpinnerPart { wrongCollision(sh) }
                else if let sh = b.node as? Shape, let _ = a.node as? SpinnerPart { wrongCollision(sh) }
            }
        }
    }
    
    private func wrongCollision(_ shape: Shape) {
        scoreBoard.failed()
        
        if isEndlessGame {
            shape.failure()
        } else {
            gameEnded = true
            shape.failure() { [weak self] in
                self?.gameShouldEnd()
            }
        }
        
        failureEffect(shape.failureDuration, lastShape: shape.shapeType)
    }
    
    private func resolveCollision(between spinnerPart: SpinnerPart, and shape: Shape) {
        guard shape.actived else { shape.countToExplode(); return }
        
        let position = convert(shape.position, from: shape.parent!)
        if position.isClose(to: convert(spinnerPart.dockingPosition, from: spinnerPart), with: 16) {

            shape.position = spinner.convert(shape.position, from: shape.parent!)
            shape.zRotation -= spinner.zRotation
            shape.zPosition = 5
            shape.removeAction(forKey: Shape.ActionKey.move)
            shape.removeFromParent()
            
            spinner.addChild(shape)
            let num = scoreBoard.points+1
            let tenMultiples = ((num%10) == 0)
            let notZero = (num != 0)
            shape.success(tenMultiples && notZero)
            
            let effect = SKTMoveEffect(node: shape, duration: shape.disappearDuration, startPosition: shape.position, endPosition: .zero)
            effect.timingFunction = SKTTimingFunctionLinear
            
            let ac: SKAction = .actionWithEffect(effect)
            if shape.waitToDisappearDuration > 0 {
                shape.run(.afterDelay(shape.waitToDisappearDuration, performAction: ac), withKey: Shape.ActionKey.move)
            } else {
                shape.run(ac, withKey: Shape.ActionKey.move)
            }
            
            scoreBoard.add1Point()
            successEffect(shape.disappearDuration + shape.creationDuration/2, shapeType: shape.shapeType)
        }
    }

    private func failureEffect(_ duration: TimeInterval, lastShape: ShapeType) {
        let shake: SKAction = .screenShakeWithNode(gameSceneNodeContainer, amount: CGPoint(x: 50, y: 10), oscillations: 4, duration: duration)
        let rotation: SKAction = .screenRotateWithNode(gameSceneNodeContainer, angle: .pi/16, oscillations: 3, duration: duration)
        
        gameSceneNodeContainer.run(.group([shake, rotation]))

        gradientNode.run(.textureGlitch(lastShape, duration: duration/4, availableTextureShape: ShapeType.allCases))
    }

    private func successEffect(_ duration: TimeInterval, shapeType: ShapeType) {
        gradientNode.setTexture(AppCache.instance.gradient(shape: shapeType),
                                byCroppingWith: AppCache.instance.backgroundCrop(shape: shapeType),
                                duration: duration)

        let shake: SKAction = .screenShakeWithNode(gameSceneNodeContainer, amount: CGPoint(x: 0, y: -36), oscillations: 2, duration: duration + 0.05)
        gameSceneNodeContainer.run(shake)
    }
    
    private func gameShouldEnd() {
        if gameEndedDoOnce == false {
            gameEndedDoOnce = true
            AppPersistence.newPlayedMatch()
            removeUIandPresentScene(InitialScene(score: scoreBoard.getScore()))
        }
    }

    private func releaseShape() {
        let node = ShapeType.randomShape()
        node.position.y = shapeStartPositionY
        node.zPosition = Constant.zPosShape
        addChildToContainer(node)
        
        let moveDiv: TimeInterval = 0.6
        let creationDiv: TimeInterval = (1 - moveDiv) * 0.6
        let disappearDiv: TimeInterval = (1 - moveDiv - creationDiv) * 0.9
        let waitToDisappearDiv: TimeInterval = 1 - moveDiv - creationDiv - disappearDiv
        
        let delay = GameTiming.delayBetweenLaunches(scoreBoard.points)
        
        node.moveDuration = moveDiv * delay
        node.creationDuration = creationDiv * delay
        node.disappearDuration = disappearDiv * delay
        node.waitToDisappearDuration = waitToDisappearDiv * delay
        
        
        node.create() { [weak self] in
            self?.scoreBoard.removeScoreLabel()
            node.activatePhysicsBody()
            node.releaseMe()
        }
    }
    
    static func calculateSceneSize(_ size: CGSize? = nil) -> CGSize {
        let size = size ?? AppDelegate.gameViewController.gameView.frame.size
        let defaultHeight: CGFloat = 736 + (AppDefines.Constants.isiPhoneX ? 30 : 0)
        let const = defaultHeight / size.height
        return CGSize(width: const * size.width, height: defaultHeight)
    }


    #if SNAPSHOT
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let c = gameSceneNodeContainer.childNode(withName: "sn_circle") as? Shape {
            // Prepare for SNAPSHOT 2
            scoreBoard.removeScoreLabel()
            c.removeFromParent()
            gradientNode.setTexture(AppCache.instance.gradient(shape: c.shapeType), byCroppingWith: AppCache.instance.backgroundCrop(shape: c.shapeType), duration: 0.1)
            
            let cc = Shape(type: .square)
            cc.creationDuration = 0.1
            cc.create()
            cc.name = "sn_square"
            cc.position.y = shapeStartPositionY - (shapeStartPositionY + abs(shapeEndPositionY)) * (1/3)
            cc.zPosition = Constant.zPosShape
            addChildToContainer(cc)
            spinner.spinn(false, delay: 0.1)
            
        } else if let c = gameSceneNodeContainer.childNode(withName: "sn_square") as? Shape {
            // Prepare for SNAPSHOT 3
            c.removeFromParent()
            gradientNode.setTexture(AppCache.instance.gradient(shape: c.shapeType), byCroppingWith: AppCache.instance.backgroundCrop(shape: c.shapeType), duration: 0.1)
            scoreBoard.removeAllActions()
            scoreBoard.tapTutorial()
            leftArrow.addMarker()
            rightArrow.addMarker()
            
            let cc = Shape(type: .triangle)
            cc.creationDuration = 0.1
            cc.name = "sn_triangle"
            cc.create()
            cc.position.y = shapeStartPositionY - (shapeStartPositionY + abs(shapeEndPositionY)) * (2/3)
            cc.zPosition = Constant.zPosShape
            addChildToContainer(cc)
            spinner.spinn(false, delay: 0.1)
            
        } else if let c = gameSceneNodeContainer.childNode(withName: "sn_triangle") as? Shape {
            // Prepare for SNAPSHOT 4
            c.removeFromParent()
            gradientNode.setTexture(AppCache.instance.gradient(shape: c.shapeType), byCroppingWith: AppCache.instance.backgroundCrop(shape: c.shapeType), duration: 0.1)
            leftArrow.stopAnimating()
            rightArrow.stopAnimating()
            scoreBoard.TESTdisplayNumber(14)
            
            let cc = Shape(type: .pentagon)
            cc.creationDuration = 0.1
            cc.create()
            cc.name = "sn_pentagon"
            cc.position.y = shapeEndPositionY
            cc.zPosition = Constant.zPosShape
            addChildToContainer(cc)
            
        } else if let c = gameSceneNodeContainer.childNode(withName: "sn_pentagon") as? Shape {
            // CLEANING
            c.removeFromParent()
            scoreBoard.removeScoreLabel()
            
        } else {
            // Prepare for SNAPSHOT 1
            let c = Shape(type: .pentagon)
            gradientNode.setTexture(AppCache.instance.gradient(shape: c.shapeType), byCroppingWith: AppCache.instance.backgroundCrop(shape: c.shapeType), duration: 0.1)
            
            let cc = Shape(type: .circle)
            cc.creationDuration = 0.1
            cc.create()
            cc.name = "sn_circle"
            cc.position.y = shapeStartPositionY
            cc.zPosition = Constant.zPosShape
            addChildToContainer(cc)
            spinner.spinn(true, delay: 0.1)
            scoreBoard.removeAllActions()
            scoreBoard.letsGo(8, completion: {})

        }
    }
    
    #else
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        for touch: AnyObject in touches {

            let location = touch.location(in: self)
            actionRecognized(location.x >= size.width/2 ? true : false)
        }
    }

    private func actionRecognized(_ right: Bool) {
        if gameStarted {
            let delay = GameTiming.spinnerDelay(scoreBoard.points)
            if right {
                rightArrow.tap()
                spinner.spinn(true, delay: delay)
                isWaitingForRight = false
            } else {
                leftArrow.tap()
                spinner.spinn(false, delay: delay)
                isWaitingForLeft = false
            }
        } else {
            if right {
                if isWaitingForRight {
                    rightArrow.tap()
                    spinner.spinn(true)
                    isWaitingForRight = false
                }
            } else {
                if isWaitingForLeft {
                    leftArrow.tap()
                    spinner.spinn(false)
                    isWaitingForLeft = false
                }
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        updateTimer.update(currentTime: currentTime)

        let t = GameTiming.delayBetweenLaunches(scoreBoard.points)
        if (updateTimer.timeSinceLastLap >= t || firstShape) && !gameEnded && gameStarted {
            self.releaseShape()
            updateTimer.lap()
            firstShape = false
        }
    }
    #endif

    override func didSimulatePhysics() {
        for node in self.children where node is Shape {
            node.position.x = size.width/2
        }
    }
    
    private enum GameTiming {
        private static let minDelayBetweenLaunches: Double = 1.4
        private static let maxDelayBetweenLaunches: Double = 3
        private static let minSpinnerDelay: Double = 0.12
        private static let maxSpinnerDelay: Double = 0.2
        
        static func delayBetweenLaunches(_ points: Int) -> Double {
            let x = Double(points)
            let y = pow(0.971, x) + sin(x/2) * 0.02 + 0.02
            return y.relative(min: minDelayBetweenLaunches, max: maxDelayBetweenLaunches)
        }
        
        static func spinnerDelay(_ points: Int) -> Double {
            let x = Double(points)
            let y: Double = pow(0.98, x)
            return y.relative(min: minSpinnerDelay, max: maxSpinnerDelay)
        }
    }
}
