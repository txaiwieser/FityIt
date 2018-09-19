//
//  ButtonsDemoScene.swift
//  TWSpriteKitUtils
//
//  Created by Txai Wieser on 9/17/15.
//  Copyright © 2015 Txai Wieser. All rights reserved.
//

import SpriteKit
import TWSpriteKitUtils

class SwitchesDemoScene: SKScene {
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        
        
        TWControl.defaultTouchDownSoundFileName = "touchDownDefault.wav"
        TWControl.defaultTouchUpSoundFileName = "touchUpDefault.wav"
        TWControl.defaultDisabledTouchDownFileName = "touchDown_disabled.wav"
        
        textureButton.touchDownSoundFileName = "touchDown.wav"
        textureButton.touchUpSoundFileName = "touchUp.wav"
        
        textureSwitch.touchDownSoundFileName = "touchDown.wav"
        textureSwitch.touchUpSoundFileName = "touchUp.wav"
        
        backgroundColor = SKColor(red: 80/255, green: 227/255, blue: 194/255, alpha: 1)
        
        addChild(switchesContainer)
        switchesContainer.addChild(colorSwitch)
        switchesContainer.addChild(textureSwitch)
        switchesContainer.addChild(textSwitch)
        
        addChild(buttonsContainer)
        buttonsContainer.addChild(colorButton)
        buttonsContainer.addChild(textureButton)
        buttonsContainer.addChild(textButton)
        
        
        addChild(SKSpriteNode(color: UIColor.red, size: CGSize(width: 200, height: 200)))
        colorSwitch.addClosure(.touchUpInside, target: self) { (scene, control) -> () in
            scene.textureSwitch.enabled = control.selected
            scene.textSwitch.enabled = control.selected
        }
        
        textureSwitch.addClosure(.touchUpInside, target: self) { (scene, control) -> () in
            scene.colorSwitch.enabled = control.selected
            scene.textSwitch.enabled = control.selected
        }
        
        textSwitch.addClosure(.touchUpInside, target: self) { (scene, control) -> () in
            scene.colorSwitch.enabled = control.selected
            scene.textureSwitch.enabled = control.selected
            print(control.selected)
        }
        
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
    
    // SWITCHES
    lazy var switchesContainer:SKSpriteNode = {
        let n = SKSpriteNode(color: SKColor.white, size: CGSize(width: 220, height: 320))
        n.position = CGPoint(x: self.frame.midX, y: self.frame.height - n.size.height/2 - 30)
        
        let l = SKLabelNode(text: "Switches")
        l.fontName = "Helvetica"
        l.fontColor = SKColor.black
        l.position = CGPoint(x: 0, y: n.size.height/2-l.frame.height - 10)
        n.addChild(l)
        return n
        }()
    
    lazy var colorSwitch:TWSwitch = {
        let s = TWSwitch(size: CGSize(width: 102, height: 40), normalColor: SKColor.blue, selectedColor: SKColor.orange)
        s.disabledStateColor = SKColor.gray
        s.setDisabledStateLabelText("DISABLED")
        s.setNormalStateLabelText("ON")
        s.setSelectedStateLabelText("OFF")
        s.setAllStatesLabelFontSize(20)
        s.setAllStatesLabelFontName("Helvetica")
        s.position = CGPoint(x: 0, y: 40)
        return s
        }()
    
    lazy var textureSwitch:TWSwitch = {
        let s = TWSwitch(normalTexture: SKTexture(imageNamed: "switch_off"), selectedTexture: SKTexture(imageNamed: "switch_on"))
        s.disabledStateTexture = SKTexture(imageNamed: "switch_d")
        s.highlightedStateSingleTexture = SKTexture(imageNamed: "button_n")
        s.position = CGPoint(x: 0, y: -40)
        return s
        }()
    
    lazy var textSwitch:TWSwitch = {
        let s = TWSwitch(normalText: "ON", selectedText: "OFF")
        s.setDisabledStateLabelText("DISABLED")
        s.setHighlightedStateSingleLabelText("HIGH")
        s.setAllStatesLabelFontColor(SKColor.black)
        s.position = CGPoint(x: 0, y: -120)
        return s
        }()
    
    
    // BUTTONS
    lazy var buttonsContainer:SKSpriteNode = {
        let n = SKSpriteNode(color: SKColor.white, size: CGSize(width: 220, height: 320))
        n.position = CGPoint(x: self.frame.midX, y: n.size.height/2 + 30)
        
        let l = SKLabelNode(text: "Buttons")
        l.fontName = "Helvetica"
        l.fontColor = SKColor.black
        l.position = CGPoint(x: 0, y: n.size.height/2-l.frame.height - 10)
        n.addChild(l)
        return n
        }()
    
    lazy var colorButton:TWButton = {
        let b = TWButton(size: CGSize(width: 102, height: 40), normalColor: SKColor.purple, highlightedColor: nil)
        b.disabledStateColor = SKColor.gray
        b.setDisabledStateLabelText("DISABLED")
        b.setNormalStateLabelText("PLAY")
        b.setHighlightedStateSingleLabelText("PRESSED")
        b.setAllStatesLabelFontSize(20)
        b.setAllStatesLabelFontName("Helvetica")
        b.position = CGPoint(x: 0, y: 40)
        return b
        }()
    
    lazy var textureButton:TWButton = {
        let b = TWButton(normalTexture: SKTexture(imageNamed: "button_n"), highlightedTexture: SKTexture(imageNamed: "button_h"))
        b.disabledStateTexture = SKTexture(imageNamed: "button_d")
        b.position = CGPoint(x: 0, y: -40)
        return b
        }()
    
    lazy var textButton:TWButton = {
        let b = TWButton(normalText: "PLAY", highlightedText: "PRESSED")
        b.setDisabledStateLabelText("DISABLED")
        b.setAllStatesLabelFontColor(SKColor.black)
        b.position = CGPoint(x: 0, y: -120)
        return b
        }()
}
