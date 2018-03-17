//
//  Spinner.swift
//  FityIt
//
//  Created by Txai Wieser on 13/03/18.
//  Copyright © 2018 Txai Wieser. All rights reserved.
//

import SpriteKit

class Spinner: SKSpriteNode {
    private let sectionsCount: Int = 8
    private let frameSide: CGFloat = 180
    private var section: CGFloat {
        return 2 * .pi / CGFloat(sectionsCount)
    }
    private var activedSection:Int = 0
    private var soundCounter = 0
    private var up = true
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    init() {
        let texture = SKTexture(circleOfRadius: frameSide, color: .mirageBlack)
        super.init(texture: texture, color: .clear, size: CGSize(width: 2.4 * frameSide, height: 2.4 * frameSide))
        
        let line = UIBezierPath()
        let lineSize = CGSize(width: 2 * frameSide / (1 + sqrt(2)), height: frameSide)
        line.move(to: CGPoint(x: -lineSize.width / 2, y: lineSize.height / 2))
        
        let shapes = ShapeType.allCases
        let shapesCount = ShapeType.allCases.count
        for i in 0 ..< sectionsCount {
            let shape = shapes[i % shapesCount]
            let radius = frameSide / 2
            let rotation =  CGFloat(i) * section
            
            let node = SpinnerPart(lenght: frameSide, shape: shape, color: .clear)
            node.zRotation =  CGFloat(sectionsCount - i) * section
            node.position = CGPoint(x: radius * sin(rotation), y: radius * cos(rotation))
            node.zPosition = 10
            addChild(node)
            
            shape.drawBorder(onPath: line, size: lineSize)

            line.apply(CGAffineTransform(translationX: 0, y: frameSide / 2))
            line.apply(CGAffineTransform(rotationAngle: .pi / 4))
            line.apply(CGAffineTransform(translationX: 0, y: -frameSide / 2))
        }
        
        line.close()
        
        let shapeNode = SKShapeNode(path: line.cgPath, centered: true)
        shapeNode.lineWidth = 6
        shapeNode.lineCap = .round
        shapeNode.lineJoin = .round
        shapeNode.fillColor = .darkBlack
        shapeNode.strokeColor = .white
        addChild(shapeNode)
        shapeNode.zPosition = 12
    }
    
    func spinn(_ right: Bool, delay: Double = 0.2) {
        if let act = soundFor(right) { run(act) }
        if right { activedSection -= 1 }
        else { activedSection += 1 }
        snapTo(CGFloat(activedSection) * section, delay: delay)
    }
    
    private func snapTo(_ angle: CGFloat, delay: Double) {
        let isRotatingActionKey = "isRotatingActionKey"
        let effect = SKTRotateEffect(node: self, duration: delay, startAngle: self.zRotation, endAngle: angle)
        effect.timingFunction = SKTTimingFunctionSmoothstep
        if action(forKey: isRotatingActionKey) != nil { removeAction(forKey: isRotatingActionKey) }
        run(.actionWithEffect(effect), withKey: isRotatingActionKey)
    }
    
    private func soundFor(_ right: Bool) -> SKAction? {
        return .playSoundFileIfEnabled("spinner_turn.wav", waitForCompletion: true)
    }
}
