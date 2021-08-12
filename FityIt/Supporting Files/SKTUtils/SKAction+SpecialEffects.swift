import SpriteKit

public extension SKAction {
    /**
     * Creates a screen shake animation.
     *
     * @param node The node to shake. You cannot apply this effect to an SKScene.
     * @param amount The vector by which the node is displaced.
     * @param oscillations The number of oscillations; 10 is a good value.
     * @param duration How long the effect lasts. Shorter is better.
     */
    static func screenShakeWithNode(_ node: SKNode, amount: CGPoint, oscillations: Int, duration: TimeInterval) -> SKAction {
        let oldPosition = node.position
        let newPosition = oldPosition + amount
        
        let effect = SKTMoveEffect(node: node, duration: duration, startPosition: newPosition, endPosition: oldPosition)
        effect.timingFunction = SKTCreateShakeFunction(oscillations)
        
        return SKAction.actionWithEffect(effect)
    }
    
    /**
     * Creates a screen rotation animation.
     *
     * @param node You usually want to apply this effect to a pivot node that is
     *        centered in the scene. You cannot apply the effect to an SKScene.
     * @param angle The angle in radians.
     * @param oscillations The number of oscillations; 10 is a good value.
     * @param duration How long the effect lasts. Shorter is better.
     */
    static func screenRotateWithNode(_ node: SKNode, angle: CGFloat, oscillations: Int, duration: TimeInterval) -> SKAction {
        let oldAngle = node.zRotation
        let newAngle = oldAngle + angle
        
        let effect = SKTRotateEffect(node: node, duration: duration, startAngle: newAngle, endAngle: oldAngle)
        effect.timingFunction = SKTCreateShakeFunction(oscillations)
        
        return SKAction.actionWithEffect(effect)
    }
    
    /**
     * Creates a screen zoom animation.
     *
     * @param node You usually want to apply this effect to a pivot node that is
     *        centered in the scene. You cannot apply the effect to an SKScene.
     * @param amount How much to scale the node in the X and Y directions.
     * @param oscillations The number of oscillations; 10 is a good value.
     * @param duration How long the effect lasts. Shorter is better.
     */
    static func screenZoomWithNode(_ node: SKNode, amount: CGPoint, oscillations: Int, duration: TimeInterval) -> SKAction {
        let oldScale = CGPoint(x: node.xScale, y: node.yScale)
        let newScale = oldScale * amount
        
        let effect = SKTScaleEffect(node: node, duration: duration, startScale: newScale, endScale: oldScale)
        effect.timingFunction = SKTCreateShakeFunction(oscillations)
        
        return SKAction.actionWithEffect(effect)
    }
    
    /**
     * Causes the scene background to flash for duration seconds.
     */
    static func colorGlitchWithScene(_ scene: SKScene, originalColor: SKColor, duration: TimeInterval) -> SKAction {
        return SKAction.customAction(withDuration: duration) {(node, elapsedTime) in
            if elapsedTime < CGFloat(duration) {
                scene.backgroundColor = SKColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1.0)
            } else {
                scene.backgroundColor = originalColor
            }
        }
    }
}
