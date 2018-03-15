//
//  AppDefines.swift
//  FityIt
//
//  Created by Txai Wieser on 14/03/18.
//  Copyright © 2018 Txai Wieser. All rights reserved.
//

import Foundation
import SpriteKit

enum AppDefines {
    enum Constants {
        static let mainLeaderboardID = "FityItLeaderboard"
        //    let DEVICE_NOT_IPAD_NEITHER_64_BIT =  UIDevice.current.userInterfaceIdiom == .phone && (MemoryLayout<Int>.size == MemoryLayout<Int64>.size ? false : true)
    }
    
    enum FontName {
        static let defaultLight = "VAGRoundedStd-Light"
        static let defaultBlack = "VAGRoundedStd-Black"
        static let defaultBold = "VAGRoundedStd-Bold"
    }
    
    enum Timings {
        static let fadeIn: TimeInterval = 0.6
        static let fadeOut: TimeInterval = 0.4
        static let slide: TimeInterval = 0.6
        static let transitionDelay: TimeInterval = 0.4
    }
    
    enum Transition {
        static let toGame = SKTransition.doorsOpenVertical(withDuration: Timings.transitionDelay)
        static let toInitial = SKTransition.doorsCloseVertical(withDuration: Timings.transitionDelay)
    }
}
