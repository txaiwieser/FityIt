//
//  File.swift
//  Repel
//
//  Created by Txai Wieser on 7/22/15.
//
//

import SpriteKit

open class TWCollectionNode: SKSpriteNode {
    open fileprivate(set) var fillMode: FillMode
    open fileprivate(set) var subNodes: [SKNode] = []
    
    open var reloadCompletion: (()->())? = nil
    required public init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    public init(fillMode: FillMode) {
        self.fillMode = fillMode
        super.init(texture: nil, color: SKColor.clear, size: CGSize(width: fillMode.width, height: 0))
    }
    
    
    open func reloadCollection() {
        let elements = subNodes.count
        let columns = fillMode.columns
        
        let xDiv = (fillMode.width - CGFloat(fillMode.columns)*fillMode.objectSize.width) / CGFloat(fillMode.columns-1)
        let lines = Int(ceil(CGFloat(elements)/CGFloat(columns)))
        var accumulatedHeight = CGFloat(0)
        for lineIndex in 0..<lines {
            let resta = elements - lineIndex*columns
            let distance = fillMode.objectSize.height + fillMode.verticalMargin
            for columnIdex in 0..<min(columns, resta) {
                var xPos = (-size.width/2 + fillMode.objectSize.width/2)
                xPos += CGFloat(columnIdex)*(fillMode.objectSize.width+xDiv)
                let yPos = -CGFloat(lineIndex)*distance - fillMode.objectSize.height/2
                subNodes[lineIndex*columns + columnIdex].position = CGPoint(x: xPos, y: yPos)
            }
            accumulatedHeight += distance
        }
        subNodes.forEach { $0.position.y += accumulatedHeight/2 - self.fillMode.verticalMargin/2 }
        self.size.height = accumulatedHeight - self.fillMode.verticalMargin
        
        reloadCompletion?()
    }
    
    open func add(node: SKNode, reload: Bool = false) {
        subNodes.append(node)
        self.addChild(node)
        
        if reload {
            self.reloadCollection()
        }
    }
    
    open func remove(node: SKNode?, reload: Bool = false) {
        if let n = node {
            n.removeFromParent()
            if let ind = subNodes.index(of: n) {
                subNodes.remove(at: ind)
            }
            
            if reload {
                self.reloadCollection()
            }
        }
    }
    
    public struct FillMode {
        let columns: Int
        let width: CGFloat
        let verticalMargin: CGFloat
        let objectSize: CGSize
        
        public init(columns: Int, width: CGFloat, verticalMargin: CGFloat, objectSize: CGSize) {
            self.columns = columns
            self.width = width
            self.verticalMargin = verticalMargin
            self.objectSize = objectSize
        }
    }
}


public extension SKNode {
    public func removeNodeFromCollection(_ withRefresh: Bool = true) {
        if let collection = self.parent as? TWCollectionNode {
            collection.remove(node: self, reload: withRefresh)
        } else {
            let message = "TWSKUtils ERROR: Node is not in a TWCollectionNode"
            assertionFailure(message)
        }
    }
}
