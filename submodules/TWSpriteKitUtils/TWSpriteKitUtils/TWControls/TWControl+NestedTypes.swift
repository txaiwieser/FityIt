//
//  TWControl+NestedTypes.swift
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

public extension TWControl {
    
    // MARK: Nested Types
    public enum ControlEvent {
        
        case touchDown // on all touch downs
        case touchUpInside
        case touchUpOutside
        case touchCancel
        case touchDragExit
        case touchDragOutside
        case touchDragEnter
        case touchDragInside
        case valueChanged // sliders, etc.
        case disabledTouchDown
    }
    
    internal enum TWControlState {
        case normal
        case highlighted
        case selected
        case disabled
        func asString() -> String {
            switch self {
            case .normal:
                return "Normal"
            case .highlighted:
                return "Highlighted"
            case .selected:
                return "Selected"
            case .disabled:
                return "Disabled"
            }
        }
    }
    
    internal enum TWControlType {
        case texture
        case shape
        case color
        case label
    }
    
    internal class TWShapeNode: SKShapeNode {
        weak var control: TWControl?
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesBegan(touches, with: event)
            control?.touchesBegan(touches, with: event)
        }
        override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesMoved(touches, with: event)
            control?.touchesMoved(touches, with: event)
        }
        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesEnded(touches, with: event)
            control?.touchesEnded(touches, with: event)
        }
        override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesCancelled(touches, with: event)
            control?.touchesCancelled(touches, with: event)
        }
    }
    
    internal class TWSpriteNode: SKSpriteNode {
        weak var control: TWControl?
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesBegan(touches, with: event)
            control?.touchesBegan(touches, with: event)
        }
        override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesMoved(touches, with: event)
            control?.touchesMoved(touches, with: event)
        }
        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesEnded(touches, with: event)
            control?.touchesEnded(touches, with: event)
        }
        override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesCancelled(touches, with: event)
            control?.touchesCancelled(touches, with: event)
        }
    }
}


public extension SKShapeNode {
    public convenience init(definition: Definition) {
        self.init()
        self.redefine(definition)
    }
    func redefine(_ definition: Definition) {
        self.path = definition.path
        self.strokeColor = definition.strokeColor
        self.fillColor = definition.fillColor
        self.lineWidth = definition.lineWidth
        self.glowWidth = definition.glowWidth
        self.fillTexture = definition.fillTexture
    }
    
    func definition() -> Definition {
        var shapeDef = Definition(path: self.path!)
        shapeDef.path = self.path!
        shapeDef.strokeColor = self.strokeColor
        shapeDef.fillColor = self.fillColor
        shapeDef.lineWidth = self.lineWidth
        shapeDef.glowWidth = self.glowWidth
        shapeDef.fillTexture = self.fillTexture
        return shapeDef
    }
    
    // MARK: Shape Definition - Description
    public struct Definition {
        var path: CGPath
        var strokeColor: UIColor = SKColor.white
        var fillColor: UIColor = SKColor.clear
        var lineWidth: CGFloat = 1.0
        var glowWidth: CGFloat = 0.0
        var fillTexture: SKTexture? = nil
        
        public init(path: CGPath) {
            self.path = path
        }
        public init(path: CGPath, color: SKColor) {
            self.path = path
            self.fillColor = color
            self.strokeColor = color
        }
        public init(_ node: SKShapeNode) {
            self = node.definition()
        }
        public init?(_ node: SKShapeNode?) {
            if let shape = node { self.init(shape) }
            else { return nil }
        }
    }
}
