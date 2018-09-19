//
//  File.swift
//  Repel
//
//  Created by Txai Wieser on 7/22/15.
//
//

import SpriteKit


open class TWStackNode: SKSpriteNode {
    open private(set) var fillMode: FillMode = FillMode.vertical
    open private(set) var subNodes: [SKNode] = []
    public let automaticSpacing: Bool
    
    required public init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    public init(lenght: CGFloat, fillMode: FillMode) {
        self.fillMode = fillMode
        self.automaticSpacing = false
        super.init(texture: nil, color: SKColor.clear, size: fillMode.size(lenght))
    }
    
    public init(size: CGSize, fillMode: FillMode) {
        self.fillMode = fillMode
        self.automaticSpacing = true
        super.init(texture: nil, color: SKColor.clear, size: size)
    }
    
    open func reloadStack() {
        var accumulatedLenght = CGFloat(0)
        
        switch fillMode {
        case .vertical:
            if automaticSpacing {
                let firstMargin = subNodes.first!.calculateAccumulatedFrame().height/2
                let lastMargin = subNodes.last!.calculateAccumulatedFrame().height/2

                for (index, node) in subNodes.enumerated() {
                    node.position.y = -CGFloat(index)*(size.height - firstMargin - lastMargin)/CGFloat(subNodes.count-1) + self.size.height/2
                    node.position.y -= firstMargin
                }
            } else {
                for node in subNodes {
                    let f = node.calculateAccumulatedFrame()
                    let ff =  f.maxY
                    _ = ff - f.size.height/2
                    
                    node.position.y = -(accumulatedLenght + f.size.height/2)// - fff
                    accumulatedLenght += f.size.height
                }
                subNodes.forEach { $0.position.y += accumulatedLenght/2 }
                self.size.height = accumulatedLenght
            }
            
        case .horizontal:
            if automaticSpacing {
                for (index, node) in subNodes.enumerated() {
                    let firstMargin = subNodes.first!.calculateAccumulatedFrame().width/2
                    let lastMargin = subNodes.last!.calculateAccumulatedFrame().width/2
                    node.position.x = CGFloat(index)*(size.width - firstMargin - lastMargin)/CGFloat(subNodes.count-1) - self.size.width/2
                    node.position.x += firstMargin
                }
            } else  {
                for node in subNodes {
                    let f = node.calculateAccumulatedFrame()
                    let ff =  f.minX
                    let fff = ff + f.size.width/2
                    
                    node.position.x = (accumulatedLenght + f.size.width/2) - fff
                    accumulatedLenght += f.size.width
                }
                subNodes.forEach { $0.position.x -= accumulatedLenght/2 }
                self.size.width = accumulatedLenght
            }
        }
        
    }
    
    open func add(node: SKNode, reload: Bool = false) {
        subNodes.append(node)
        self.addChild(node)
        
        if reload {
            self.reloadStack()
        }
    }
    
    open func remove(node: SKNode?, reload: Bool = false) {
        if let n = node {
            n.removeFromParent()
            if let ind = subNodes.index(of: n) {
                subNodes.remove(at: ind)
            }
        
            if reload {
                self.reloadStack()
            }
        }
    }
    
    public enum FillMode {
        case horizontal
        case vertical
        
        func size(_ lenght: CGFloat) -> CGSize {
            switch self {
            case .horizontal:
                return CGSize(width: lenght, height: 2)
            case .vertical:
                return CGSize(width: 2, height: lenght)
            }
        }
        
        func lenght(_ size: CGSize) -> CGFloat {
            switch self {
            case .horizontal:
                return size.width
            case .vertical:
                return size.height
            }
        }
    }
}

public extension SKNode {
    public func removeNodeFromStack(_ withRefresh: Bool = true) {
        if let stack = self.parent as? TWStackNode {
            stack.remove(node: self, reload: withRefresh)
        } else {
            let message = "TWSKUtils ERROR: Node is not in a TWStackNode"
            assertionFailure(message)
        }
    }
}
