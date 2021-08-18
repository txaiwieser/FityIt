//
//  CGPoint+IsCloseTo.swift.swift
//  FityIt
//
//  Created by Txai Wieser on 16/03/18.
//  Copyright © 2018 Txai Wieser. All rights reserved.
//

import Foundation
import CoreGraphics

extension CGPoint {
    func isClose(to point: CGPoint, with range: CGFloat) -> Bool {
        let xMax = point.x + range
        let xMin = point.x - range
        let yMax = point.y + range
        let yMin = point.y - range
        
        if (x >= xMin && x <= xMax) && (y >= yMin && y <= yMax) {
            return true
        } else {
            return false
        }
    }
}
