//
//  SKNode+AfterDelay.swift
//  FityIt
//
//  Created by Txai Wieser on 14/03/18.
//  Copyright © 2018 Txai Wieser. All rights reserved.
//

import SpriteKit

extension SKNode {
    public func afterDelay(_ delay: TimeInterval, runBlock block: @escaping () -> Void) {
        run(.sequence([.wait(forDuration: delay), .run(block)]))
    }
}
