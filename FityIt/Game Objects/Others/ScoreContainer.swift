//
//  ScoreContainer.swift
//  FityIt
//
//  Created by Txai Wieser on 13/03/18.
//  Copyright © 2018 Txai Wieser. All rights reserved.
//

import SpriteKit

class ScoreContainer: SKSpriteNode {
    
    func setScore(_ score: Score) {
        var fScale = size.height * 0.5
        let conSize1 = CGSize(width: 1.18 * fScale, height: fScale)
        fScale *= 0.8
        let conSize2 = CGSize(width: 0.8 * fScale, height: fScale)

        let leftContainer = SKSpriteNode(color: .clear, size: conSize1)
        let rightContainer = SKSpriteNode(color: .clear, size: conSize2)

    
        rightContainer.position.x = 0.3033 * size.width
    
    
        leftContainer.position.y = -size.height * (0.068)
        rightContainer.position.y = -size.height * (0.068)

        rightContainer.position.y -= rightContainer.size.height * (0.09)
    
        leftContainer.zPosition = 1
        rightContainer.zPosition = 1
        addChild(leftContainer)
        addChild(rightContainer)
    
        let leftTitle = createTitleLabel(NSLocalizedString("PANEL_HIGH_SCORE", comment: ""), fontSize: 0.2 * leftContainer.size.height)
        let rightTitle = createTitleLabel(NSLocalizedString("PANEL_SCORE", comment: ""), fontSize: 0.2 * rightContainer.size.height)
    
        leftContainer.addChild(leftTitle)
        rightContainer.addChild(rightTitle)
    
    
        leftTitle.maxWidth = leftContainer.size.width
        rightTitle.maxWidth = rightContainer.size.width
    
    
        rightTitle.position.x = rightTitle.frame.size.width * 0.024
        leftTitle.position.y = leftContainer.size.height * (0.5 - 0.1 - 0.07)
        rightTitle.position.y = rightContainer.size.height * (0.5 - 0.1 - 0.07)
    
        let leftSubtitle = createSubtitleLabel(String(score.highScorePoints()), fontSize: 0.7 * leftContainer.size.height)
        let rightSubtitle = createSubtitleLabel(String(score.points), fontSize: 0.7 * rightContainer.size.height)
    
        leftSubtitle.maxWidth = leftContainer.size.width * 0.8
        rightSubtitle.maxWidth = rightContainer.size.width * 1.2
    
        leftSubtitle.position.y = leftContainer.size.height * (0.5 - 0.7 + 0.07)
        rightSubtitle.position.y = rightContainer.size.height * (0.5 - 0.7 + 0.07)
    
        leftContainer.addChild(leftSubtitle)
        rightContainer.addChild(rightSubtitle)
    }

    func createTitleLabel(_ text: String, fontSize: CGFloat) -> LPRFixedWidthLabelNode {
        let l = LPRFixedWidthLabelNode(text: text)
        l.fontName = AppDefines.FontName.defaultLight
        l.fontSize = fontSize
        l.horizontalAlignmentMode = .center
        l.verticalAlignmentMode = .center
        l.truncationMode = .scale
        return l
    }
    
    func createSubtitleLabel(_ text: String, fontSize: CGFloat) -> LPRFixedWidthLabelNode {
        let l = LPRFixedWidthLabelNode(text: text)
        l.truncationMode = .scale
        l.fontName = AppDefines.FontName.defaultBold
        l.fontSize = fontSize
        l.horizontalAlignmentMode = .center
        l.verticalAlignmentMode = .center
        return l
    }
}
