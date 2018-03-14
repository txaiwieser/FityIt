//
//  ShapeType+Paths.swift
//  FityIt
//
//  Created by Txai Wieser on 14/03/18.
//  Copyright © 2018 Txai Wieser. All rights reserved.
//

import SpriteKit

extension ShapeType {
    enum Circle {
        private static let radius: CGFloat = 40
        //    private let insidePercentage:CGFloat { return 0.46 }
        
        static func path() -> UIBezierPath {
            let size = CGSize(width: 2 * radius, height: 2 * radius)
            let origin = CGPoint(x: -radius, y: -radius)
            return UIBezierPath(ovalIn: CGRect(origin: origin, size: size))
        }
    }
    
    enum Square {
        private static let length: CGFloat = 66
//        static let insidePercentage: CGFloat = 0.5
        
        static func path() -> UIBezierPath {
            let size = CGSize(width: length, height: length)
            let origin = CGPoint(x: -length/2, y: -length/2)
            return UIBezierPath(rect: CGRect(origin: origin, size: size))
        }
    }
    
    enum Triangle {
        private static let base: CGFloat = 90
        private static let height: CGFloat = 80
//        private static let insidePercentage: CGFloat = 0.66
        
        static func path() -> UIBezierPath {
            let size = CGSize(width: base, height: height)
            return UIBezierPath(triangleIn: size)
        }
    }
    
    enum Pentagon {
        private static let width: CGFloat = 82
//        private static let insidePercentage: CGFloat = 0.8
        
        static func path() -> UIBezierPath {
            return UIBezierPath(pentagonWith: width)
        }
    }
}
