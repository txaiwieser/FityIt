//
//  ButtonsDemoScene.swift
//  TWSpriteKitUtils
//
//  Created by Txai Wieser on 9/17/15.
//  Copyright © 2015 Txai Wieser. All rights reserved.
//

import SpriteKit
import TWSpriteKitUtils

class CollectionNodeDemoScene: SKScene {
    var collection:TWCollectionNode!
        
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.lightGray
        
        collection = TWCollectionNode(fillMode: TWCollectionNode.FillMode(columns: 3, width: view.frame.size.width*0.8, verticalMargin: 30, objectSize: CGSize(width: 100, height: 100)))
        collection.position = CGPoint(x: (view.frame).midX, y: (view.frame).midY)
        collection.color = SKColor.blue
        addChild(collection)
        
        let addButton = TWButton(normalText: "Add", highlightedText: nil)
        addButton.highlightedStateSingleColor = SKColor.black
        addButton.normalStateColor = SKColor.white
        addButton.position = CGPoint(x: (view.frame).midX + 200, y: (view.frame).midY + 400)
        addButton.addClosure(.touchUpInside, target: self) { (target, sender) -> () in
            target.addToCollection()
        }
        
        let removeButton = TWButton(normalText: "Remove", highlightedText: nil)
        removeButton.highlightedStateSingleColor = SKColor.black
        removeButton.normalStateColor = SKColor.white
        removeButton.position = CGPoint(x: (view.frame).midX - 200, y: (view.frame).midY + 400)
        removeButton.addClosure(.touchUpInside, target: self) { (target, sender) -> () in
            target.removeFromCollection()
        }

        
        addChild(addButton)
        addChild(removeButton)
    }
    
    func addToCollection() {
        func randomColor() -> SKColor {
            let colors = [SKColor.red, SKColor.green, SKColor.blue, SKColor.cyan, SKColor.yellow, SKColor.magenta, SKColor.orange]
            return colors[Int(arc4random_uniform(UInt32(colors.count)))]
        }
        
        let node = SKSpriteNode(color: randomColor(), size: CGSize(width: 100, height: 100))
        collection.add(node: node, reload: true)
    }
    
    func removeFromCollection() {
        let node = collection.subNodes.last
        collection.remove(node: node, reload: true)
    }
}
