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
        let sides: CGFloat = 5
        let lenght = width * sqrt((sides - sqrt(sides)) / 10)
        
        for i in 0..<5 {
            let angle: CGFloat = CGFloat(i) * ((sides * .pi) / sides) - (.pi / 2)
            let point = CGPoint(x: lenght * cos(angle), y: -lenght * sin(angle) + 2 * ((width / 2) - lenght))
            
            if i == 0 { move(to: point) }
            else { addLine(to: point) }
        }
        close()
    }
}
