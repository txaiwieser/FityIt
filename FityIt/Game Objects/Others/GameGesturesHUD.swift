//
//  GameGesturesHUD.swift
//  FityIt
//
//  Created by Txai Wieser on 13/03/18.
//  Copyright © 2018 Txai Wieser. All rights reserved.
//

import SpriteKit

class GameGesturesHUD: SKNode {
    private let anim: SKAction = {
        var array = [SKAction]()
        for i in [CGFloat(1.0) ,1.4, 0.9, 1.15, 0.95, 1.02, 1.0] {
            array.append(.scale(to: i, duration: 0.08))
        }
        return .sequence(array)
    }()
    
    private let arrow: SKSpriteNode!
    private let radius: CGFloat
    
    private lazy var marker: SKSpriteNode = {
        let t = SKTexture(image: .circle(withRadius: 2 * self.radius, color: .white))
        let n = SKSpriteNode(texture: t, size: CGSize(width: self.radius, height: self.radius))
        n.alpha = 0.5
        return n
    }()
    
    func addMarker() {
        if marker.parent == nil {
            addChild(marker)
            marker.setScale(1)
            marker.alpha = 0.5
        }
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    init(right: Bool, radius: CGFloat) {
        self.radius = radius
        self.arrow = SKSpriteNode(texture: AppCache.instance.mainAtlas.textureNamed("game_arrow_right"))
        
        if !right {
            arrow.xScale = -1
        }
        super.init()
        self.addChild(arrow)
    }
    
    func tap() {
        run(anim)
    }
    
    func repeatTapEvery(_ sec: TimeInterval = 1) {
        if marker.parent == nil {
            addChild(marker)
        }
        run(.repeatForever(.afterDelay(sec, performAction: anim)))
    }
    
    func stopAnimating() {
        marker.run(.scale(to: 0, duration: 0.1), completion: { [weak self] in
            self?.marker.removeFromParent()
            self?.removeAllActions()
        }) 
    }
}
