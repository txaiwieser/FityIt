//
//  ShapeType+Properties.swift
//  FityIt
//
//  Created by Txai Wieser on 14/03/18.
//  Copyright © 2018 Txai Wieser. All rights reserved.
//

import SpriteKit

extension ShapeType {
    func name() -> String {
        switch self {
        case .circle:
            return "Circle"
        case .square:
            return "Square"
        case .triangle:
            return "Triangle"
        case .pentagon:
            return "Pentagon"
        }
    }
    
    func textureName() -> String {
        switch self {
        case .circle:
            return "shape_circle"
        case .square:
            return "shape_square"
        case .triangle:
            return "shape_triangle"
        case .pentagon:
            return "shape_pentagon"
        }
    }
    
    func path() -> UIBezierPath {
        switch self {
        case .circle:
            return Circle.path()
        case .square:
            return Square.path()
        case .triangle:
            return Triangle.path()
        case .pentagon:
            return Pentagon.path()
        }
    }
    
    func spinnerPath(size: CGSize) -> UIBezierPath {
        switch self {
        case .circle:
            return Circle.spinnerPath(size: size)
        case .square:
            return Square.spinnerPath(size: size)
        case .triangle:
            return Triangle.spinnerPath(size: size)
        case .pentagon:
            return Pentagon.spinnerPath(size: size)
        }
    }
    
    func drawBorder(onPath path: UIBezierPath, size: CGSize) {
        switch self {
        case .circle:
            Circle.drawBorder(onPath: path, size: size)
        case .square:
            Square.drawBorder(onPath: path, size: size)
        case .triangle:
            Triangle.drawBorder(onPath: path, size: size)
        case .pentagon:
            Pentagon.drawBorder(onPath: path, size: size)
        }
    }
    
    func color() -> SKColor {
        switch self {
        case .pentagon:
            return .rosa
        case .square:
            return .laranja
        case .triangle:
            return .roxo
        case .circle:
            return .verde
        }
    }
}
