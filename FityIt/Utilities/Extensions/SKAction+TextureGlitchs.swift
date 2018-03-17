//
//  SKAction+GlitchColors.swift
//  FityIt
//
//  Created by Txai Wieser on 15/03/18.
//  Copyright © 2018 Txai Wieser. All rights reserved.
//

import SpriteKit

extension SKAction {
    static func textureGlitch(_ originalTextureShape: ShapeType, duration: TimeInterval, availableTextureShape: [ShapeType]) -> SKAction {
        let remainingTextures = availableTextureShape.filter { $0 != originalTextureShape }
        var interElapsedTime: CGFloat = 0
        return .customAction(withDuration: duration) {(node, elapsedTime) in
            if elapsedTime < CGFloat(duration) {
                if elapsedTime >= interElapsedTime {
                    interElapsedTime += CGFloat(duration)/3.4
                    (node as! SKSpriteNode).texture = AppCache.instance.gradient(shape: remainingTextures[Int.random(within: 0..<remainingTextures.count)])
                }
            } else {
                (node as! SKSpriteNode).texture = nil
                (node as! SKSpriteNode).color = .darkerBlack
            }
        }
    }
}

