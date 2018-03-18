//
//  Score.swift
//  FityIt
//
//  Created by Txai Wieser on 13/03/18.
//  Copyright © 2018 Txai Wieser. All rights reserved.
//

import Foundation

struct Score {
    var points = 0
    
    init(points: Int) {
        self.points = points
    }
    
    func highScorePoints() -> Int {
        return AppPersistence.highScorePoints
    }
}
