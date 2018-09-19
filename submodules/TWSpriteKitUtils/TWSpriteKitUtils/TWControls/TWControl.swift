//
//  TWButton.swift
//
//  The MIT License (MIT)
//
//  Created by Txai Wieser on 25/02/15.
//  Copyright (c) 2015 Txai Wieser.
//
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//SOFTWARE.
//
//

import SpriteKit

open class TWControl: SKNode {

    // MARK: Initializers

    required public init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    /**
    * Initializes a general TWControl of type .Texture with a single highlighted texture possibility
    */
    public init(normalTexture: SKTexture, selectedTexture: SKTexture?, singleHighlightedTexture: SKTexture?, disabledTexture: SKTexture?) {
        type = .texture
        super.init()
        self.generalSprite = TWSpriteNode(texture: normalTexture, size: normalTexture.size())
        (self.generalSprite as! TWSpriteNode).control = self
        self.addChild(self.generalSprite)
        self.isUserInteractionEnabled = false
        self.generalSprite.isUserInteractionEnabled = true

        self.disabledStateTexture = disabledTexture
        self.highlightedStateSingleTexture = singleHighlightedTexture
        self.normalStateTexture = normalTexture
        self.selectedStateTexture = selectedTexture
        
        updateVisualInterface()
    }
    
    /**
    * Initializes a general TWControl of type .Texture with multiple highlighted textures possibility
    */
    public init(normalTexture: SKTexture, selectedTexture: SKTexture?, multiHighlightedTexture: (fromNormal: SKTexture?, fromSelected: SKTexture?), disabledTexture: SKTexture?) {
        type = .texture
        super.init()
        self.generalSprite = TWSpriteNode(texture: normalTexture, size: normalTexture.size())
        (self.generalSprite as! TWSpriteNode).control = self
        self.addChild(self.generalSprite)
        self.isUserInteractionEnabled = false
        self.generalSprite.isUserInteractionEnabled = true
        
        self.disabledStateTexture = disabledTexture
        self.highlightedStateMultiTextureFromNormal = multiHighlightedTexture.fromNormal
        self.highlightedStateMultiTextureFromSelected = multiHighlightedTexture.fromSelected
        self.normalStateTexture = normalTexture
        self.selectedStateTexture = selectedTexture
        
        updateVisualInterface()
    }
    
    
    /**
    * Initializes a general TWControl of type .Shape with a single highlighted texture possibility
    */
    public init(normalShape: SKShapeNode.Definition, selectedShape: SKShapeNode.Definition?, singleHighlightedShape: SKShapeNode.Definition?, disabledShape: SKShapeNode.Definition?) {
        type = .shape
        super.init()
        self.generalShape = TWShapeNode(definition: normalShape)
        (self.generalShape as! TWShapeNode).control = self
        self.addChild(self.generalShape)
        self.isUserInteractionEnabled = false
        self.generalShape.isUserInteractionEnabled = true
        
        self.disabledStateShapeDef = disabledShape
        self.highlightedStateSingleShapeDef = singleHighlightedShape
        self.normalStateShapeDef = normalShape
        self.selectedStateShapeDef = selectedShape
        
        updateVisualInterface()
    }
    
    /**
    * Initializes a general TWControl of type .Shape with multiple highlighted textures possibility
    */
    public init(normalShape: SKShapeNode.Definition, selectedShape: SKShapeNode.Definition?, multiHighlightedShape: (fromNormal: SKShapeNode.Definition?, fromSelected: SKShapeNode.Definition?), disabledShape: SKShapeNode.Definition?) {
        type = .shape
        super.init()
        self.generalShape = TWShapeNode(definition: normalShape)
        (self.generalShape as! TWShapeNode).control = self
        self.addChild(self.generalShape)
        self.isUserInteractionEnabled = false
        self.generalShape.isUserInteractionEnabled = true
        
        self.disabledStateShapeDef = disabledShape
        self.highlightedStateMultiShapeFromNormalDef = multiHighlightedShape.fromNormal
        self.highlightedStateMultiShapeFromSelectedDef = multiHighlightedShape.fromSelected
        self.normalStateShapeDef = normalShape
        self.selectedStateShapeDef = selectedShape
        
        updateVisualInterface()
    }
    
    
    /**
    * Initializes a general TWControl of type .Color with a single highlighted color possibility
    */
    public init(size: CGSize, normalColor: SKColor, selectedColor: SKColor?, singleHighlightedColor: SKColor?, disabledColor: SKColor?) {
        type = .color
        super.init()
        self.generalSprite = TWSpriteNode(texture: nil, color: normalColor, size: size)
        (self.generalSprite as! TWSpriteNode).control = self

        self.addChild(self.generalSprite)
        self.isUserInteractionEnabled = false
        self.generalSprite.isUserInteractionEnabled = true
        
        self.disabledStateColor = disabledColor
        self.highlightedStateSingleColor = singleHighlightedColor
        self.normalStateColor = normalColor
        self.selectedStateColor = selectedColor
        
        updateVisualInterface()
    }

    /**
    * Initializes a general TWControl of type .Color with with multiple highlighted color possibility
    */
    public init(size: CGSize, normalColor: SKColor, selectedColor: SKColor?, multiHighlightedColor: (fromNormal: SKColor?, fromSelected: SKColor?), disabledColor: SKColor?) {
        type = .color
        super.init()
        self.generalSprite = TWSpriteNode(texture: nil, color: normalColor, size: size)
        (self.generalSprite as! TWSpriteNode).control = self

        self.addChild(self.generalSprite)
        self.isUserInteractionEnabled = false
        self.generalSprite.isUserInteractionEnabled = true

        self.disabledStateColor = disabledColor
        self.highlightedStateMultiColorFromNormal = multiHighlightedColor.fromNormal
        self.highlightedStateMultiColorFromSelected = multiHighlightedColor.fromSelected
        self.normalStateColor = normalColor
        self.selectedStateColor = selectedColor
        
        updateVisualInterface()
    }
    
    
    
    
    
    /**
    * Initializes a general TWControl of type .Text with multiple highlighted color possibility
    */
    public init(normalText: String, selectedText: String?, singleHighlightedText: String?, disabledText: String?) {
        type = .label
        super.init()
        self.isUserInteractionEnabled = true

        setNormalStateLabelText(normalText)
        setSelectedStateLabelText(selectedText)
        setDisabledStateLabelText(disabledText)
        setHighlightedStateSingleLabelText(singleHighlightedText)
        
        updateVisualInterface()
    }
    
    /**
    * Initializes a general TWControl of type .Text with multiple highlighted color possibility
    */
    public init(normalText: String, selectedText: String?, multiHighlightedText: (fromNormal: String?, fromSelected: String?), disabledText: String?)  {
        type = .label
        super.init()
        self.isUserInteractionEnabled = true
        
        setNormalStateLabelText(normalText)
        setSelectedStateLabelText(selectedText)
        setDisabledStateLabelText(disabledText)
        setHighlightedStateMultiLabelTextFromNormal(multiHighlightedText.fromNormal)
        setHighlightedStateMultiLabelTextFromSelected(multiHighlightedText.fromSelected)
        
        updateVisualInterface()
    }
    
    // MARK: Control Actions
    
    /**
    * Add a closure to a event action. You should use in your closure only the objects that are on the capture list of the closure (target)!
    Using objects capture automatically by the closure can cause cycle-reference, and your objects will never be deallocate. 
    You have to be CAREFUL with this! Just pass your object to the function and use inside the closure.
    */
    open func addClosure<T: AnyObject>(_ event: ControlEvent, target: T, closure: @escaping (_ target: T, _ sender: TWControl) -> ()) {
        self.eventClosures.append((event:event , closure: { [weak target] (ctrl: TWControl) -> () in
            if let obj = target {
                closure(obj, ctrl)
            }
            return
            }))
    }
    
    /**
    * Removes all closure from a specific event.
    */
    open func removeClosures(for event: ControlEvent) {
        assertionFailure("TODO: Implement Remove Target")
    }

    fileprivate func executeClosures(of event: ControlEvent) {
        for eventClosure in eventClosures {
            if eventClosure.event == event {
                eventClosure.closure(self)
            }
        }
    }
    
    
    
    
    
    // MARK: Public Properties
    
    open var size: CGSize { get { return self.calculateAccumulatedFrame().size } }
    open var tag: Int?
    open var enabled: Bool {
        get {
            return self.state != .disabled
        }
        set {
            if newValue {
                self.state = .normal
            } else {
                self.state = .disabled
            }
            updateVisualInterface()
        }
    }
    
    open var selected: Bool {
        get {
            return self.state == .selected
        }
        set {
            if newValue {
                self.state = .selected
            } else {
                self.state = .normal
            }
            updateVisualInterface()
        }
    }
    
    open var highlighted: Bool {
        get {
            return self.state == .highlighted
        }
        set {
            if newValue {
                self.state = .highlighted
            } else {
                self.state = .normal
            }
            updateVisualInterface()
        }
    }
    
    
    open func setGeneralTouchProperties(_ changes: (_ node: SKNode)->()) {
        if generalSprite != nil {
            changes(generalSprite)
        } else if generalShape != nil {
            changes(generalShape)
        }
    }
    
    
    // MARK: General Nodes
    
    fileprivate var generalSprite: SKSpriteNode!
    fileprivate var generalShape: SKShapeNode!
    
    override open var isUserInteractionEnabled: Bool {
        didSet {
            self.generalSprite?.isUserInteractionEnabled = isUserInteractionEnabled
            self.generalShape?.isUserInteractionEnabled = isUserInteractionEnabled
        }
    }
    
    open var genericNode: SKNode {
        get {
            if let gen = generalSprite {
                return gen
            }
            else if let gen = generalShape {
                return gen
            }
            else {
                return self
            }
        }
    }
    
    // MARK: Sound Properties
    
    public static var defaultSoundEffectsEnabled: Bool? = nil
    open var soundEffectsEnabled: Bool = true
    
    public static var defaultTouchDownSoundFileName: String? {
        didSet { soundPreLoad(defaultTouchDownSoundFileName) }
    }
    public static var defaultTouchUpSoundFileName: String? {
        didSet { soundPreLoad(defaultTouchUpSoundFileName) }
    }
    public static var defaultDisabledTouchDownFileName: String? {
        didSet { soundPreLoad(defaultDisabledTouchDownFileName) }
    }
    
    open var touchDownSoundFileName: String? {
        didSet { TWControl.soundPreLoad(touchDownSoundFileName) }
    }
    open var touchUpSoundFileName: String? {
        didSet { TWControl.soundPreLoad(touchUpSoundFileName) }
    }
    open var disabledTouchDownFileName: String? {
        didSet { TWControl.soundPreLoad(disabledTouchDownFileName) }
    }
    
    fileprivate static func soundPreLoad(_ named: String?) {
        // Preloads the sound
        if let named = named {
            if #available(iOS 9.0, *) {
                _ = SKAction.playSoundFileNamed(named, waitForCompletion: true)
            }
        }
    }
    
    // MARK: COLOR Type Customizations
    
    open var normalStateColor: SKColor! { didSet { updateVisualInterface() } }
    open var selectedStateColor: SKColor? { didSet { updateVisualInterface() } }
    open var disabledStateColor: SKColor? { didSet { updateVisualInterface() } }
    open var highlightedStateSingleColor: SKColor? { didSet { updateVisualInterface() } }
    open var highlightedStateMultiColorFromNormal: SKColor? { didSet { updateVisualInterface() } }
    open var highlightedStateMultiColorFromSelected: SKColor? { didSet { updateVisualInterface() } }
    

    
    
    // MARK: TEXTURE Type Customizations

    open var normalStateTexture: SKTexture! { didSet { updateVisualInterface() } }
    open var selectedStateTexture: SKTexture? { didSet { updateVisualInterface() } }
    open var disabledStateTexture: SKTexture? { didSet { updateVisualInterface() } }
    open var highlightedStateSingleTexture: SKTexture? { didSet { updateVisualInterface() } }
    open var highlightedStateMultiTextureFromNormal: SKTexture? { didSet { updateVisualInterface() } }
    open var highlightedStateMultiTextureFromSelected: SKTexture? { didSet { updateVisualInterface() } }
    
    
    // MARK: SHAPE Type Customizations
    
    open var normalStateShapeDef: SKShapeNode.Definition! { didSet { updateVisualInterface() } }
    open var selectedStateShapeDef: SKShapeNode.Definition? { didSet { updateVisualInterface() } }
    open var disabledStateShapeDef: SKShapeNode.Definition? { didSet { updateVisualInterface() } }
    open var highlightedStateSingleShapeDef: SKShapeNode.Definition? { didSet { updateVisualInterface() } }
    open var highlightedStateMultiShapeFromNormalDef: SKShapeNode.Definition? { didSet { updateVisualInterface() } }
    open var highlightedStateMultiShapeFromSelectedDef: SKShapeNode.Definition? { didSet { updateVisualInterface() } }
    
    
    
    
    
    
    
    
    
    
    // MARK: TEXT Type Customizations
    
    open var normalStateLabel: SKLabelNode? { didSet { updateVisualInterface() } }
    open var selectedStateLabel: SKLabelNode? { didSet { updateVisualInterface() } }
    open var disabledStateLabel: SKLabelNode? { didSet { updateVisualInterface() } }
    open var highlightedStateSingleLabel: SKLabelNode? { didSet { updateVisualInterface() } }
    open var highlightedStateMultiLabelFromNormal: SKLabelNode? { didSet { updateVisualInterface() } }
    open var highlightedStateMultiLabelFromSelected: SKLabelNode? { didSet { updateVisualInterface() } }
    
    
    // Labels Text Setters
    
    public static var defaultLabelFont = "Helvetica-Neue"

    open func setNormalStateLabelText(_ text: String?) {
        self.setLabelText(&normalStateLabel, text: text, pos: normalStateLabelPosition)
    }
    open func setSelectedStateLabelText(_ text: String?) {
        self.setLabelText(&selectedStateLabel, text: text, pos: selectedStateLabelPosition)
    }
    open func setDisabledStateLabelText(_ text: String?) {
        self.setLabelText(&disabledStateLabel, text: text, pos: disabledStateLabelPosition)
    }
    open func setHighlightedStateSingleLabelText(_ text: String?) {
        self.setLabelText(&highlightedStateSingleLabel, text: text, pos: highlightedStateSingleLabelPosition)
    }
    open func setHighlightedStateMultiLabelTextFromNormal(_ text: String?) {
        self.setLabelText(&highlightedStateMultiLabelFromNormal, text: text, pos: highlightedStateMultiLabelPositionFromNormal)
    }
    open func setHighlightedStateMultiLabelTextFromSelected(_ text: String?) {
        self.setLabelText(&highlightedStateMultiLabelFromSelected, text: text, pos: highlightedStateMultiLabelPositionFromSelected)
    }
    fileprivate func setLabelText(_ label: inout SKLabelNode?, text: String?, pos: CGPoint) {
        if let newText = text {
            if label == nil {
                label = generalLabel()
                label!.position = pos
                self.genericNode.addChild(label!)
            }
            label!.text = newText
        } else {
            label?.removeFromParent()
            label = nil
        }
    }
    fileprivate func generalLabel() -> SKLabelNode {
        let l = SKLabelNode()
        l.fontName = TWControl.defaultLabelFont
        l.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        l.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        return l
    }
    
    
    
    // Labels Font Size Setter

    open func setAllStatesLabelFontSize(_ size: CGFloat) {
        normalStateLabel?.fontSize = size
        selectedStateLabel?.fontSize = size
        disabledStateLabel?.fontSize = size
        highlightedStateSingleLabel?.fontSize = size
        highlightedStateMultiLabelFromNormal?.fontSize = size
        highlightedStateMultiLabelFromSelected?.fontSize = size
    }
    
    // Labels Font Name Setter
    
    open func setAllStatesLabelFontName(_ fontName: String) {
        normalStateLabel?.fontName = fontName
        selectedStateLabel?.fontName = fontName
        disabledStateLabel?.fontName = fontName
        highlightedStateSingleLabel?.fontName = fontName
        highlightedStateMultiLabelFromNormal?.fontName = fontName
        highlightedStateMultiLabelFromSelected?.fontName = fontName
    }
    
    // Labels Font Color Setter

    open func setNormalStateLabelFontColor(_ color: SKColor) {
        normalStateLabel?.fontColor = color
    }
    open func setSelectedStateLabelFontColor(_ color: SKColor) {
        selectedStateLabel?.fontColor = color
    }
    open func setDisabledStateLabelFontColor(_ color: SKColor) {
        disabledStateLabel?.fontColor = color
    }
    open func setHighlightedStateSingleLabelFontColor(_ color: SKColor) {
        highlightedStateSingleLabel?.fontColor = color
    }
    open func setHighlightedStateMultiLabelFontColorFromNormal(_ color: SKColor) {
        highlightedStateMultiLabelFromNormal?.fontColor = color
    }
    open func setHighlightedStateMultiLabelFontColorFromSelected(_ color: SKColor) {
        highlightedStateMultiLabelFromSelected?.fontColor = color
    }
    open func setAllStatesLabelFontColor(_ color: SKColor) {
        setNormalStateLabelFontColor(color)
        setSelectedStateLabelFontColor(color)
        setDisabledStateLabelFontColor(color)
        setHighlightedStateSingleLabelFontColor(color)
        setHighlightedStateMultiLabelFontColorFromNormal(color)
        setHighlightedStateMultiLabelFontColorFromSelected(color)
    }
    
    // Default Control Label Position
    
    public static var defaultNormalStateLabelPosition = CGPoint.zero
    public static var defaultSelectedStateLabelPosition = CGPoint.zero
    public static var defaultDisabledStateLabelPosition = CGPoint.zero
    public static var defaultHighlightedStateSingleLabelPosition = CGPoint.zero
    public static var defaultHighlightedStateMultiLabelPositionFromNormal = CGPoint.zero
    public static var defaultHighlightedStateMultiLabelPositionFromSelected = CGPoint.zero
    public static func setAllDefaultStatesLabelPosition(_ pos: CGPoint) {
        defaultNormalStateLabelPosition = pos
        defaultSelectedStateLabelPosition = pos
        defaultDisabledStateLabelPosition = pos
        defaultHighlightedStateSingleLabelPosition = pos
        defaultHighlightedStateMultiLabelPositionFromNormal = pos
        defaultHighlightedStateMultiLabelPositionFromSelected = pos
    }
    
    // Control Instance Label Position
    
    open var normalStateLabelPosition: CGPoint = defaultNormalStateLabelPosition {
        didSet { normalStateLabel?.position = normalStateLabelPosition }
    }
    open var selectedStateLabelPosition: CGPoint = defaultSelectedStateLabelPosition {
        didSet { selectedStateLabel?.position = selectedStateLabelPosition }
    }
    open var disabledStateLabelPosition: CGPoint = defaultDisabledStateLabelPosition {
        didSet { disabledStateLabel?.position = disabledStateLabelPosition }
    }
    open var highlightedStateSingleLabelPosition: CGPoint = defaultHighlightedStateSingleLabelPosition {
        didSet { highlightedStateSingleLabel?.position = highlightedStateSingleLabelPosition }
    }
    open var highlightedStateMultiLabelPositionFromNormal: CGPoint = defaultHighlightedStateMultiLabelPositionFromNormal {
        didSet { highlightedStateMultiLabelFromNormal?.position = highlightedStateMultiLabelPositionFromNormal }
    }
    open var highlightedStateMultiLabelPositionFromSelected: CGPoint = defaultHighlightedStateMultiLabelPositionFromSelected {
        didSet { highlightedStateMultiLabelFromSelected?.position = highlightedStateMultiLabelPositionFromSelected }
    }
    open func setAllStatesLabelPosition(_ pos: CGPoint) {
        normalStateLabelPosition = pos
        selectedStateLabelPosition = pos
        disabledStateLabelPosition = pos
        highlightedStateSingleLabelPosition = pos
        highlightedStateMultiLabelPositionFromNormal = pos
        highlightedStateMultiLabelPositionFromSelected = pos
    }

    
    // Control Animations
    
    public static var defaultAnimationHighlightedAction: (to: SKAction, back: SKAction)? = nil
    open var animationHighlightedAction: (to: SKAction, back: SKAction)? = defaultAnimationHighlightedAction

    
    

    
    
    
    
    
    // MARK: Private Properties
    
    fileprivate let type: TWControlType
    fileprivate var state: TWControlState = .normal { didSet { lastState = oldValue } }
    fileprivate var lastState: TWControlState = .normal
    internal var eventClosures: [(event: ControlEvent, closure: (TWControl) -> ())] = []
    fileprivate var touch:UITouch?
    fileprivate var touchLocationLast: CGPoint?
    fileprivate var moved = false

    
    // MARK: Control Functionality
    
    fileprivate func updateVisualInterface() {
        switch type {
            case .color:
                updateColorVisualInterface()
            case .texture:
                updateTextureVisualInterface()
            case .shape:
                updateShapeVisualInterface()
            case .label:
                break //Doesnt need to do nothing
        }
        
        updateLabelsVisualInterface()
        if self.scene?.view?.window != nil { updateAnimationInterface() }
    }
    
    func updateAnimationInterface() {
        let ANIMATION_HIGHLIGHTED_ACTION = "ANIMATION_HIGHLIGHTED_ACTION"
        if let animation = animationHighlightedAction {
            genericNode.removeAction(forKey: ANIMATION_HIGHLIGHTED_ACTION)
            switch state {
            case .normal: fallthrough
            case .disabled:
                genericNode.run(animation.back, withKey: ANIMATION_HIGHLIGHTED_ACTION)
            case .highlighted: fallthrough
            case .selected:
                genericNode.run(animation.to, withKey: ANIMATION_HIGHLIGHTED_ACTION)
            }
        }
    }
    
    fileprivate func updateColorVisualInterface() {
        switch state {
        case .normal:
            self.generalSprite.color = self.normalStateColor
        case .selected:
            if let selColor = self.selectedStateColor {
                self.generalSprite.color = selColor
            } else {
                self.generalSprite.color = normalStateColor
            }
        case .disabled:
            if let disColor = self.disabledStateColor {
                self.generalSprite.color = disColor
            } else {
                self.generalSprite.color = normalStateColor
            }
        case .highlighted:
            
            if let single = highlightedStateSingleColor {
                self.generalSprite.color = single
            } else {
                if lastState == .normal {
                    if let fromNormal = self.highlightedStateMultiColorFromNormal {
                        self.generalSprite.color = fromNormal
                    }
                    else if let sel = self.selectedStateColor {
                        self.generalSprite.color = sel
                    }
                    else {
                        self.generalSprite.color = self.normalStateColor
                    }
                }
                else if lastState == .selected {
                    if let fromSelected = self.highlightedStateMultiColorFromSelected {
                        self.generalSprite.color = fromSelected
                    }
                    else {
                        self.generalSprite.color = self.normalStateColor
                    }
                }
            }
        }
    }

    
    fileprivate func updateTextureVisualInterface() {
        switch state {
        case .normal:
            self.generalSprite.texture = self.normalStateTexture
        case .selected:
            if let selTex = self.selectedStateTexture {
                self.generalSprite.texture = selTex
            } else {
                self.generalSprite.texture = normalStateTexture
            }
        case .disabled:
            if let disTex = self.disabledStateTexture {
                self.generalSprite.texture = disTex
            } else {
                self.generalSprite.texture = normalStateTexture
            }
        case .highlighted:
            
            if let single = highlightedStateSingleTexture {
                self.generalSprite.texture = single
            } else {
                if lastState == .normal {
                    if let fromNormal = self.highlightedStateMultiTextureFromNormal {
                        self.generalSprite.texture = fromNormal
                    }
                    else if let sel = self.selectedStateTexture {
                        self.generalSprite.texture = sel
                    }
                    else {
                        self.generalSprite.texture = self.normalStateTexture
                    }
                } else if lastState == .selected {
                    if let fromSelected = self.highlightedStateMultiTextureFromSelected {
                        self.generalSprite.texture = fromSelected
                    }
                    else {
                        self.generalSprite.texture = self.normalStateTexture
                    }
                }
            }
        }
        // This line was removed to fix the animation bug where the size of the button would change after animate. It appears nothings break by the remove so far
//        self.generalSprite.size = self.generalSprite.texture!.size()
    }
    
    fileprivate func updateShapeVisualInterface() {
        switch state {
        case .normal:
            self.generalShape.redefine(normalStateShapeDef)
        case .selected:
            if let selSha = self.selectedStateShapeDef {
                self.generalShape.redefine(selSha)
            } else {
                self.generalShape.redefine(normalStateShapeDef)
            }
        case .disabled:
            if let disSha = self.disabledStateShapeDef {
                self.generalShape.redefine(disSha)
            } else {
                self.generalShape.redefine(normalStateShapeDef)
            }
        case .highlighted:
            
            if let single = highlightedStateSingleShapeDef {
                self.generalShape.redefine(single)
            } else {
                if lastState == .normal {
                    if let fromNormal = self.highlightedStateMultiShapeFromNormalDef {
                        self.generalShape.redefine(fromNormal)
                    }
                    else if let sel = self.selectedStateShapeDef {
                        self.generalShape.redefine(sel)
                    }
                    else {
                        self.generalShape.redefine(self.normalStateShapeDef)
                    }
                } else if lastState == .selected {
                    if let fromSelected = self.highlightedStateMultiShapeFromSelectedDef {
                        self.generalShape.redefine(fromSelected)
                    }
                    else {
                        self.generalShape.redefine(self.normalStateShapeDef)
                    }
                }
            }
        }
    }
    
    
    fileprivate func updateLabelsVisualInterface() {
        // Labels
        normalStateLabel?.alpha = 0
        selectedStateLabel?.alpha = 0
        disabledStateLabel?.alpha = 0
        highlightedStateSingleLabel?.alpha = 0
        highlightedStateMultiLabelFromNormal?.alpha = 0
        highlightedStateMultiLabelFromSelected?.alpha = 0
        
        switch state {
        case .normal:
            normalStateLabel?.alpha = 1
        case .selected:
            if let selLabel = self.selectedStateLabel {
                selLabel.alpha = 1
            } else {
                normalStateLabel?.alpha = 1
            }
        case .disabled:
            if let disLabel = self.disabledStateLabel {
                disLabel.alpha = 1
            } else {
                normalStateLabel?.alpha = 1
            }
        case .highlighted:
            if let single = highlightedStateSingleLabel {
                single.alpha = 1
            } else {
                if lastState == .normal {
                    if let fromNormal = self.highlightedStateMultiLabelFromNormal {
                        fromNormal.alpha = 1
                    } else if let selectedLabel = self.selectedStateLabel {
                        selectedLabel.alpha = 1
                    } else {
                        self.normalStateLabel?.alpha = 1
                    }
                } else if lastState == .selected {
                    if let fromSelected = self.highlightedStateMultiLabelFromSelected {
                        fromSelected.alpha = 1
                    } else {
                        self.normalStateLabel?.alpha = 1
                    }
                }
            }
        }
    }
    
    
    
    // MARK: Control Events
    
    internal func touchDown() {
        playSound(instanceSoundFileName: touchDownSoundFileName, defaultSoundFileName: TWControl.defaultTouchDownSoundFileName)
        executeClosures(of: .touchDown)
    }
    
    internal func disabledTouchDown() {
        playSound(instanceSoundFileName: disabledTouchDownFileName, defaultSoundFileName: TWControl.defaultDisabledTouchDownFileName)
        executeClosures(of: .disabledTouchDown)
    }
    
    internal func drag() {}
    
    internal func dragExit() {
        executeClosures(of: .touchDragExit)
    }

    internal func dragOutside() {
        executeClosures(of: .touchDragOutside)
    }
    
    internal func dragEnter() {
        executeClosures(of: .touchDragEnter)
    }
    
    internal func dragInside() {
        executeClosures(of: .touchDragInside)
    }

    open func touchUpInside() {
        executeClosures(of: .touchUpInside)
        playSound(instanceSoundFileName: touchUpSoundFileName, defaultSoundFileName: TWControl.defaultTouchUpSoundFileName)
    }
    
    internal func touchUpOutside() {
        executeClosures(of: .touchUpOutside)
        playSound(instanceSoundFileName: touchUpSoundFileName, defaultSoundFileName: TWControl.defaultTouchUpSoundFileName)
    }
    
    
    
    
    
    

    // MARK: UIResponder Methods
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let touchPoint = touch.location(in: self.genericNode.parent!)

        if self.genericNode.contains(touchPoint) {
            self.touch = touch
            self.touchLocationLast = touchPoint
            if self.state == .disabled {
                disabledTouchDown()
            } else {
                touchDown()
            }
        }
    }
    
    
    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.state == .disabled { return }
        let touch = touches.first!
        let touchPoint = touch.location(in: self.genericNode.parent!)
        
        drag()
        
        self.moved = true
        if self.genericNode.contains(touchPoint) {
            // Inside
            if let lastPoint = self.touchLocationLast , self.genericNode.contains(lastPoint) {
                // All along
                dragInside()
            } else {
                self.dragEnter()
            }
        } else {
            // Outside
            if let lastPoint = self.touchLocationLast , self.genericNode.contains(lastPoint) {
                // Since now
                dragExit()
            } else {
                // All along
                dragOutside()
            }
        }
        self.touchLocationLast = touchPoint
    }
    
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        endedTouch()
    }
    
    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        endedTouch()
    }
    
    fileprivate func endedTouch() {
        if self.state == .disabled { return }
        
        if self.moved {
            if let lastPoint = self.touchLocationLast , self.genericNode.contains(lastPoint) {
                // Ended inside
                touchUpInside()
            } else {
                // Ended outside
                touchUpOutside()
            }
        } else {
            // Needed??
            touchUpInside()
        }
        self.moved = false
    }
}
