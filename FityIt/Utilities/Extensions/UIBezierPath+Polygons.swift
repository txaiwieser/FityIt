//
//  UIBezierPath+Polygons.swift
//  FityIt
//
//  Created by Txai Wieser on 13/03/18.
//  Copyright © 2018 Txai Wieser. All rights reserved.
//
//  Based on: https://github.com/ZevEisenberg/ZEPolygon, thanks man!

import UIKit

extension UIBezierPath {
    convenience init(triangleIn size: CGSize) {
        self.init()
        
        let width = size.width
        let height = size.height
        let halfWitdth = width/2
        let halfHeight = height/2
        
        move(to: CGPoint(x: -halfWitdth, y: halfHeight))
        addLine(to: CGPoint(x: halfWitdth, y: halfHeight))
        addLine(to: CGPoint(x: 0, y: -halfHeight))
        close()
    }
    
    convenience init(pentagonWith width: CGFloat) {
        self.init()
        
        let sidesCount: Int = 5
        let sides = CGFloat(sidesCount)
        
        let length = width * sqrt((sides - sqrt(sides)) / 10)
        
        for i in 0..<sidesCount {
            let angle: CGFloat = CGFloat(i) * ((2 * .pi) / sides) - (.pi / 2)
            let point = CGPoint(x: length * cos(angle), y: -length * sin(angle) + 2 * ((width / 2) - length))
            
            if i == 0 { move(to: point) }
            else { addLine(to: point) }
        }
        close()
    }
}
