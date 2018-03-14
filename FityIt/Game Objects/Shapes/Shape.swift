//
//  Shape.swift
//  FityIt
//
//  Created by Txai Wieser on 13/03/18.
//  Copyright © 2018 Txai Wieser. All rights reserved.
//

import SpriteKit

class Shape: SKSpriteNode {
    private enum Constant {
        static let defaultSize = CGSize(width: 50, height: 50)
        static let moveDuration: TimeInterval = 0.8
        static let creationDuration: TimeInterval = 0.4
        static let disappearDuration: TimeInterval = 0.2
        static let waitToDisappearDuration: TimeInterval = 0
        static let failureDuration: TimeInterval = 0.8
    }
    
    private enum ActionKey: String {
        case isAboutToExplode
        case move
    }
    
    private var actived = true
    private let shapeType: ShapeType
    private let shapeColors: SKColor
    private let shapeName: String
    private let shapePath: UIBezierPath

    init(type: ShapeType) {
        shapeType = type
        shapeColors = type.color()
        shapeName = type.name()
        shapePath = type.path()
        super.init(texture: nil, color: .clear, size: Constant.defaultSize)
        
        run(.setTexture(AppCache.instance.mainAtlas.textureNamed(type.textureName()), resize: true))

        if BUILD_MODE == .debug {
            let mark = SKSpriteNode(color: .white, size: CGSize(width: 4, height: 4))
            mark.zPosition = 10
            mark.position = .zero
            addChild(mark)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func activatePhysicsBody(_ path: UIBezierPath) {
        let physicsBody = SKPhysicsBody(polygonFrom: path.cgPath)
        let shapeCategory = PhysicsCategory.category(of: shapeType)
        physicsBody.categoryBitMask = shapeCategory.rawValue
        physicsBody.collisionBitMask = PhysicsCategory.collision(with: shapeCategory)
        physicsBody.contactTestBitMask = PhysicsCategory.contact(with: shapeCategory)
        physicsBody.allowsRotation = true
        physicsBody.usesPreciseCollisionDetection = true
        physicsBody.friction = 10
        physicsBody.mass = 0
        physicsBody.restitution = 0
        physicsBody.linearDamping = 0
        physicsBody.angularDamping = 0
        self.physicsBody = physicsBody
    }
    
    
    
    func countToExplode() {
        self.run(SKAction.sequence([SKAction.wait(forDuration: 1), SKAction.run({ () -> Void in
            self.failure()
        })]), withKey: ActionKey.isAboutToExplode.rawValue)
    }
    
    func releaseMe() {
//        let effect = SKTMoveEffect(node: self, duration: moveDuration, startPosition: self.position, endPosition: CGPoint(x: 0, y: -scene!.size.height/2))
//        effect.timingFunction = SKTTimingFunctionLinear
//        let ac = SKAction.actionWithEffect(effect)
//        self.run(ac, withKey: ActionKey.move.rawValue)
    }
    
    var creationTextures:[SKTexture]?
    
    func create(_ completion: (() -> Void)? = nil) {
//        let act = SKAction.apearAnimated(self, time: CGFloat(Constant.creationDuration), scale: 1)
//
//        if let c = completion { run(act, completion: c) }
//        else { run(act) }
//
//        if let a = GameSingleton.instance.creationSound { run(SKAction.afterDelay(Constant.creationDuration, performAction: a)) }
    }
    
    func success(_ special: Bool, completion: (() -> Void)? = nil) {
        
//        actived = false
//        self.removeAllActions()
//        if special {
//            if let a = GameSingleton.instance.successSoundSpecial { run(a) }
//        } else {
//            if let a = GameSingleton.instance.successSound { run(a) }
//        }
//        self.physicsBody = nil
//
//        let a = SKAction.disapearAnimated(self, time: CGFloat(disappearDuration))
//        let seq = SKAction.sequence([a, SKAction.removeFromParent()])
//        if waitToDisappearDuration > 0 {
//            self.run(SKAction.afterDelay(waitToDisappearDuration, performAction: seq))
//        } else {
//            self.run(seq)
//        }
        
    }
    
    func failure(_ completion: (() -> Void)? = nil) {
//        actived = false
//        self.removeAllActions()
//        if let a = GameSingleton.instance.failureSound { run(a) }
//        self.physicsBody = nil
//        let a = SKAction.disapearAnimated(self, time: CGFloat(failureDuration/2))
//        let action = SKAction.sequence([SKAction.group([a, SKAction.wait(forDuration: failureDuration*2)]), SKAction.removeFromParent()])
//
//        if let c = completion {
//            self.run(action, completion: c)
//        } else {
//            self.run(action)
//        }
    }
    
    
    func animationAction(_ textures: [SKTexture], duration: TimeInterval, completion: (() -> Void)? = nil) -> SKAction {
        let group = SKAction.animate(with: textures, timePerFrame: duration/TimeInterval(textures.count), resize: true, restore: false)
        var seq = [group]
//        if let c = completion {
//            let wc = SKAction.afterDelay(duration, runBlock: c)
//            seq.append(wc)
//        }
        return SKAction.group(seq)
    }
}
