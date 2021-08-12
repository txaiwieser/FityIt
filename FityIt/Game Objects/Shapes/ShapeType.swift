//
//  ShapeFactory.swift
//  FityIt
//
//  Created by Txai Wieser on 13/03/18.
//  Copyright © 2018 Txai Wieser. All rights reserved.
//

import SpriteKit

enum ShapeType: CaseIterable, Equatable {
    case circle
    case square
    case triangle
    case pentagon
    
    static var lastRandomShapeType: ShapeType?
    static func randomShape() -> Shape {
        var type: ShapeType
        repeat {
            type = allCases.randomElement()!
        } while type == lastRandomShapeType
        
        lastRandomShapeType = type
        return Shape(type: type)
    }
}

