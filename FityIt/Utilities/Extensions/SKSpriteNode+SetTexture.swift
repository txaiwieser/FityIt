//
//  SKSpriteNode+SetTexture.swift
//  FityIt
//
//  Created by Txai Wieser on 15/03/18.
//  Copyright © 2018 Txai Wieser. All rights reserved.
//

import SpriteKit

extension SKSpriteNode {
    func setTexture(_ newTexture: SKTexture, byCroppingWith spriteShape: SKSpriteNode, duration: CFTimeInterval) {
        let crop = SKCropNode()
        crop.zPosition = zPosition + 1
        crop.position = position
        
        let fadeInSprite = SKSpriteNode(texture: newTexture, size: size)
        crop.addChild(fadeInSprite)
        
        spriteShape.setScale(0.012)
        spriteShape.position.y = -fadeInSprite.size.height / 2
        spriteShape.position.x = 0
        spriteShape.zPosition = 0
        crop.maskNode = spriteShape
        parent?.addChild(crop)
        
        spriteShape.run(.scale(to: 4, duration: duration))
        crop.run(.sequence([.wait(forDuration: duration),
                            .run { [weak self] in self?.texture = newTexture },
                            .removeFromParent()]))
    }
}
