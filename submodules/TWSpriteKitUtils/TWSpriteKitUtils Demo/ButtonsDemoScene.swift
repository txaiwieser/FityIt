//
//  ButtonsDemoScene.swift
//  TWSpriteKitUtils
//
//  Created by Txai Wieser on 9/17/15.
//  Copyright © 2015 Txai Wieser. All rights reserved.
//

import SpriteKit
import TWSpriteKitUtils

class ButtonsDemoScene: SKScene {
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        
        
        TWControl.defaultTouchDownSoundFileName = "touchDownDefault.wav"
        TWControl.defaultTouchUpSoundFileName = "touchUpDefault.wav"
        TWControl.defaultDisabledTouchDownFileName = "touchDown_disabled.wav"
        
        
        backgroundColor = SKColor(red: 80/255, green: 227/255, blue: 194/255, alpha: 1)
        
        addChild(colorButton)
        addChild(textureButton)
        addChild(textButton)
        
        
        colorButton.addClosure(.touchUpInside, target: self) { (scene, control) -> () in
            scene.textureButton.enabled = !scene.textureButton.enabled
            scene.textButton.enabled = !scene.textButton.enabled
        }
        
        textureButton.addClosure(.touchUpInside, target: self) { (scene, control) -> () in
            scene.colorButton.enabled = !scene.colorButton.enabled
            scene.textButton.enabled = !scene.textButton.enabled
        }
        
        textButton.addClosure(.touchUpInside, target: self) { (scene, control) -> () in
            scene.colorButton.enabled = !scene.colorButton.enabled
            scene.textureButton.enabled = !scene.textureButton.enabled
        }
    }
    
    
    
    // BUTTONS
    
    lazy var colorButton:TWButton = {
        let b = TWButton(size: CGSize(width: 102, height: 40), normalColor: SKColor.purple, highlightedColor: nil)
        b.disabledStateColor = SKColor.gray
        b.setDisabledStateLabelText("DISABLED")
        b.setNormalStateLabelText("PLAY")
        b.setHighlightedStateSingleLabelText("PRESSED")
        b.setAllStatesLabelFontSize(20)
        b.setAllStatesLabelFontName("Helvetica")
        b.position = CGPoint(x: self.size.width/2, y: self.size.height/2 + 200)
        return b
        }()
    
    lazy var textureButton:TWButton = {
        let b = TWButton(normalTexture: SKTexture(imageNamed: "button_n"), highlightedTexture: SKTexture(imageNamed: "button_h"))
        b.disabledStateTexture = SKTexture(imageNamed: "button_d")
        b.touchDownSoundFileName = "touchDown.wav"
        b.touchUpSoundFileName = "touchUp.wav"
        
        b.position = CGPoint(x: self.size.width/2, y: self.size.height/2 + 0)
        return b
        }()
    
    lazy var textButton:TWButton = {
        let b = TWButton(normalText: "PLAY", highlightedText: "PRESSED")
        b.setDisabledStateLabelText("DISABLED")
        b.setAllStatesLabelFontColor(SKColor.black)
        b.position = CGPoint(x: self.size.width/2, y: self.size.height/2 + -200)
        return b
        }()
}
