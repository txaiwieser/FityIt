//
//  GameScoreHUD.swift
//  FityIt
//
//  Created by Txai Wieser on 13/03/18.
//  Copyright © 2018 Txai Wieser. All rights reserved.
//


import SpriteKit

class GameScoreHUD: SKLabelNode {
    private(set) var points: Int = 0 {
        didSet {
            self.text = String(points)
        }
    }
    
    private let defaultFontSize: CGFloat = 100
    private let delay: CGFloat = 1
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override init() {
        super.init()
        self.fontName = AppDefines.FontName.defaultLight
        self.verticalAlignmentMode = .bottom
        self.horizontalAlignmentMode = .center
        self.fontSize = defaultFontSize
        self.fontColor = .lightTintColor
        self.alpha = 0
    }
    
    func add1Point() {
        points = points + 1
        run(.appearAnimated(self, time: delay * 0.6))
    }
    
    func TESTdisplayNumber(_ number: Int) {
        points = number
        setScale(1)
        alpha = 1
        run(.fadeIn(withDuration: 0.1))
    }
    
    func removeScoreLabel() {
        run(.disappearAnimated(self, time: delay * 0.3))
    }
    
    func tapTutorial() {
        text = NSLocalizedString("TUTORIAL_TAP", comment: "")
        run(.appearAnimated(self, time: 0.3))
    }
    
    func letsGo(_ wait: TimeInterval = 1.4, completion: @escaping (() -> Void)) {
        text = NSLocalizedString("MSG_READY", comment: "")
        
        run(.sequence([.appearAnimated(self, time: 0.3), .wait(forDuration: wait)]), completion: {
            self.removeScoreLabel()
            completion()
        }) 
    }
    
    func failed(_ duration: CGFloat = 0.5) {
        fontSize = 150
        text = "X"
        
        run(.sequence([.appearAnimated(self, time: duration * 0.3),
                       .wait(forDuration: TimeInterval(duration) * 1.6),
                       .disappearAnimated(self, time: duration * 0.4)]), completion: {
                        self.fontSize = self.defaultFontSize
        }) 
    }
    
    func getScore() -> Score {
        return Score(points: points)
    }
}
