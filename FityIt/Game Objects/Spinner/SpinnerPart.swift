//
//  SpinnerPart.swift
//  FityIt
//
//  Created by Txai Wieser on 13/03/18.
//  Copyright © 2018 Txai Wieser. All rights reserved.
//

import SpriteKit

class SpinnerPart: SKShapeNode {
    private let dockingPosition: CGPoint
    private let type: ShapeType
    
    init(lenght: CGFloat, shape: ShapeType, color: SKColor) {
        type = shape
        dockingPosition = (shape == .triangle ? CGPoint(x: 0, y: lenght / 2 - 8) : CGPoint(x: 0, y: lenght / 2))
        super.init()
        
        let shapePath = shape.spinnerPath(size: CGSize(width: 2 * lenght / (1 + sqrt(2)), height: lenght))
        activatePhysicsBody(shapePath)
        
        if BUILD_MODE == .debug {
            let mark = SKSpriteNode(color: .lightGray, size: CGSize(width: 8, height: 8))
            mark.zPosition = 5
            mark.position = dockingPosition
            addChild(mark)
        }
    }
    
    private func activatePhysicsBody(_ path: UIBezierPath) {
        let physicsBody = SKPhysicsBody(edgeLoopFrom: path.cgPath)
        let category = PhysicsCategory.category(of: type)
        physicsBody.categoryBitMask = category.rawValue
        physicsBody.collisionBitMask = PhysicsCategory.collision(with: category)
        physicsBody.contactTestBitMask = PhysicsCategory.contact(with: category)
        physicsBody.usesPreciseCollisionDetection = true
        physicsBody.isDynamic = false
        physicsBody.restitution = 0
        self.physicsBody = physicsBody
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
