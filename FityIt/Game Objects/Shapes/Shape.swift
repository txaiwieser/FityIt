//
//  Shape.swift
//  FityIt
//
//  Created by Txai Wieser on 13/03/18.
//  Copyright © 2018 Txai Wieser. All rights reserved.
//

import SpriteKit

class Shape: SKSpriteNode {
    static let defaultSize = CGSize(width: 50, height: 50)
    var moveDuration: TimeInterval = 0.8
    var creationDuration: TimeInterval = 0.4
    var disappearDuration: TimeInterval = 0.2
    var waitToDisappearDuration: TimeInterval = 0
    var failureDuration: TimeInterval = 0.8
    
    enum ActionKey {
        static let isAboutToExplode = "isAboutToExplode"
        static let move = "move"
    }
    
    private(set) var actived = true
    let shapeType: ShapeType
    private let shapeColors: SKColor
    let shapeName: String
    private let shapePath: UIBezierPath

    init(type: ShapeType) {
        shapeType = type
        shapeColors = type.color()
        shapeName = type.name()
        shapePath = type.path()
        super.init(texture: nil, color: .clear, size: Shape.defaultSize)
        
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
        
    func activatePhysicsBody() {
        let path = shapeType.path()
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
        run(.sequence([.wait(forDuration: 1), .run({ () -> Void in
            self.failure()
        })]), withKey: ActionKey.isAboutToExplode)
    }
    
    func releaseMe() {
        let effect = SKTMoveEffect(node: self, duration: moveDuration, startPosition: position, endPosition: CGPoint(x: 0, y: -scene!.size.height/2))
        effect.timingFunction = SKTTimingFunctionLinear
        run(.actionWithEffect(effect), withKey: ActionKey.move)
    }
    
    func create(_ completion: (() -> Void)? = nil) {
        let appear: SKAction = .appearAnimated(self, time: CGFloat(creationDuration), scale: 1)

        if let completion = completion { run(appear, completion: completion) }
        else { run(appear) }

        if let sound = AppCache.instance.creationSound {
            run(.afterDelay(creationDuration, performAction: sound))
        }
    }
    
    func success(_ special: Bool, completion: (() -> Void)? = nil) {
        actived = false
        removeAllActions()
        
        if let sound = special ? AppCache.instance.successSoundSpecial : AppCache.instance.successSound {
            run(sound)
        }
        physicsBody = nil

        let disappear: SKAction = .disappearAnimated(self, time: CGFloat(disappearDuration))
        let sequence = SKAction.sequence([disappear, .removeFromParent()])
        if waitToDisappearDuration > 0 {
            run(.afterDelay(waitToDisappearDuration, performAction: sequence))
        } else {
            run(sequence)
        }
    }
    
    func failure(_ completion: (() -> Void)? = nil) {
        actived = false
        removeAllActions()
        if let failure = AppCache.instance.failureSound { run(failure) }
        physicsBody = nil
        
        let disappear: SKAction = .disappearAnimated(self, time: CGFloat(failureDuration/2))
        
        let sequence: SKAction = .sequence([.group([disappear, .wait(forDuration: failureDuration*2)]), .removeFromParent()])

        if let completion = completion {
            run(sequence, completion: completion)
        } else {
            run(sequence)
        }
    }
    
    
    func animationAction(_ textures: [SKTexture], duration: TimeInterval, completion: (() -> Void)? = nil) -> SKAction {
        let group: SKAction = .animate(with: textures, timePerFrame: duration/TimeInterval(textures.count), resize: true, restore: false)
        var sequence = [group]
        if let completion = completion {
            sequence.append(.afterDelay(duration, runBlock: completion))
        }
        return .group(sequence)
    }
}
