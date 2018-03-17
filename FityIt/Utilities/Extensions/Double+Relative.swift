//
//  CGFloat+Relative.swift
//  FityIt
//
//  Created by Txai Wieser on 14/03/18.
//  Copyright © 2018 Txai Wieser. All rights reserved.
//

import Foundation

extension Double {
    func relative(min: Double, max: Double) -> Double {
        return min + self * (max - min)
    }
}
