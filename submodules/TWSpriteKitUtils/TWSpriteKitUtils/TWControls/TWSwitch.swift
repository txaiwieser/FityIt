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

open class TWSwitch: TWControl {

    
    // MARK: Convenience Initializers
    public convenience init(normalText: String, selectedText: String?) {
        self.init(normalText: normalText, selectedText: selectedText, singleHighlightedText: nil, disabledText: nil)
    }
    
    public convenience init(normalTexture: SKTexture, selectedTexture: SKTexture?) {
        self.init(normalTexture: normalTexture, selectedTexture: selectedTexture, singleHighlightedTexture: nil, disabledTexture: nil)
    }
    
    public convenience init(normalShape: SKShapeNode.Definition, selectedShape: SKShapeNode.Definition?) {
        self.init(normalShape: normalShape, selectedShape: selectedShape, singleHighlightedShape: nil, disabledShape: nil)
    }
    
    public convenience init(size: CGSize, normalColor: SKColor, selectedColor: SKColor?) {
        self.init(size: size, normalColor: normalColor, selectedColor: selectedColor, singleHighlightedColor: nil, disabledColor: nil)
    }
    
    
    
    
    
    fileprivate var selectedStateMemory = false
    // MARK: Switch Methods
    
    open override var selected:Bool {
        get { return super.selected }
        set { super.selected = newValue; self.selectedStateMemory = newValue }
    }
    
    // MARK: TWSwitch Events
    
    internal override func touchDown() {
        self.highlighted = true
        super.touchDown()
    }
    
    internal override func disabledTouchDown() {
        super.disabledTouchDown()
    }
    
    internal override func drag() {
        super.drag()
    }
    
    internal override func dragExit() {
        self.highlighted = false
        super.dragExit()
    }
    
    internal override func dragOutside() {
        super.dragOutside()
    }
    
    internal override func dragEnter() {
        self.highlighted = true
        super.dragEnter()
    }
    
    internal override func dragInside() {
        super.dragInside()
    }
    
    // WARNING: This should not be public ;/
    open override func touchUpInside() {
        selectedStateMemory = !selectedStateMemory
        self.selected = selectedStateMemory
        super.touchUpInside()
    }
    
    internal override func touchUpOutside() {
        super.touchUpOutside()
    }

}
