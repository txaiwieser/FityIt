//
//  AppCache.swift
//  FityIt
//
//  Created by Txai Wieser on 14/03/18.
//  Copyright © 2018 Txai Wieser. All rights reserved.
//

import Foundation
import SpriteKit

class AppCache {
    static let instance: AppCache = AppCache()
    
    private init() {
        SKTextureAtlas.preloadTextureAtlases([interfaceAtlas, mainAtlas], withCompletionHandler: {})
    }
    
    // MARK: SKTextureAtlas
    
    let mainAtlas = SKTextureAtlas(named: "main")
    let interfaceAtlas = SKTextureAtlas(named: "interface")
    
    private(set) var initialScreenBackgroundTexture: SKTexture!
    
    func initializeInitialScreenBackgroundTexture(screenSize: CGSize) {
        if initialScreenBackgroundTexture == nil {
            initialScreenBackgroundTexture = SKTexture(radialGradient: CGSize(width: screenSize.width, height: screenSize.height/2), colors: [.roxo, .darkerRoxo])
        }
    }
    
    // MARK: Gradients and Background Shape Crops
    private var gradients: [ShapeType: SKTexture]?
    private var backgroundCrops: [ShapeType: SKSpriteNode]?
    
    func gradient(shape: ShapeType) -> SKTexture {
        return gradients![shape]!
    }
    
    func backgroundCrop(shape: ShapeType) -> SKSpriteNode {
        return backgroundCrops![shape]!
    }
    
    func initializeGameTextures(with size: CGSize) {
        var adjustedSize = CGSize(width: size.width/2, height: size.height/2)
        
        if gradients == nil {
            gradients = [.circle: SKTexture(radialGradient: adjustedSize, colors: [.verde, .darkerVerde]),
                         .triangle: SKTexture(radialGradient: adjustedSize, colors: [.roxo, .darkerRoxo]),
                         .square: SKTexture(radialGradient: adjustedSize, colors: [.laranja, .darkerLaranja]),
                         .pentagon: SKTexture(radialGradient: adjustedSize, colors: [.rosa, .darkerRosa])]
        }
        
        adjustedSize = CGSize(width: size.width/4, height: size.height/4)
        
        if backgroundCrops == nil {
            let outerRadiusSize = CGSize(width: adjustedSize.width, height: 2 * adjustedSize.height)
            let outerRadius = sqrt(pow(outerRadiusSize.width/2, 2) + pow(outerRadiusSize.height/2, 2))
            let circle = SKTexture(circleOfRadius: outerRadius, color: .white)
            let triangle = SKTexture(triangleWithSize: CGSize(width: (2 * adjustedSize.height) * 8/9, height: 2 * adjustedSize.height), color: .white)
            let square = SKTexture(squareOfLenght: 2 * adjustedSize.height, color: .white)
            let pentagon = SKTexture(pentagonWithWidth: 4 * adjustedSize.width, color: .white)
            
            backgroundCrops =  [.circle: SKSpriteNode(texture: circle),
                                .triangle: SKSpriteNode(texture: triangle),
                                .square: SKSpriteNode(texture: square),
                                .pentagon: SKSpriteNode(texture: pentagon)]
        }
    }
    
    // MARK: Sound Actions
    
    private(set) var creationSound: SKAction? = nil
    private(set) var successSound: SKAction? = nil
    private(set) var successSoundSpecial: SKAction? = nil
    private(set) var failureSound: SKAction? = nil
    
    func resetSounds(initializeAfter: Bool) {
        if initializeAfter {
            creationSound = nil
            successSound = SKAction.playSoundFileNamed("success_shape.wav", waitForCompletion: true)
            successSoundSpecial = SKAction.playSoundFileNamed("success_shape_special.wav", waitForCompletion: true)
            failureSound = SKAction.playSoundFileNamed("failure_shape_1.wav", waitForCompletion: true)
        } else {
            creationSound = nil
            successSound = nil
            successSoundSpecial = nil
            failureSound = nil
        }
    }
}
