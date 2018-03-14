import UIKit

public extension Double {
    /**
     * Returns a random floating point number between 0.0 and 1.0, inclusive.
     */
    public static func random() -> Double {
        return Double(Double(arc4random()) / 0xFFFFFFFF)
    }

    /**
     * Returns a random floating point number in the range min...max, inclusive.
     */
    public static func random(within range: Range<Double>) -> Double {
        return Double.random() * (range.upperBound - range.lowerBound) + range.lowerBound
    }

    /**
     * Randomly returns either 1.0 or -1.0.
    */
    public static func randomSign() -> Double {
        return (arc4random_uniform(2) == 0) ? 1.0 : -1.0
    }
}

extension Int {
    /**
     * Returns a random integer in the specified range.
     */
    public static func random(within range: Range<Int>) -> Int {
        return Int(arc4random_uniform(UInt32(range.upperBound - range.lowerBound))) + range.lowerBound
    }

    /**
     * Returns a random integer between 0 and n-1.
     */
    public static func random(_ n: Int) -> Int {
        return Int(arc4random_uniform(UInt32(n)))
    }

    /**
     * Returns a random integer in the range min...max, inclusive.
     */
    public static func random(min: Int, max: Int) -> Int {
        assert(min < max)
        return Int(arc4random_uniform(UInt32(max - min + 1))) + min
    }
}

extension CGFloat {
    /**
     * Returns a random floating point number between 0.0 and 1.0, inclusive.
     */
    public static func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    /**
     * Returns a random floating point number in the range min...max, inclusive.
     */
    public static func random(min: CGFloat, max: CGFloat) -> CGFloat {
        assert(min < max)
        return CGFloat.random() * (max - min) + min
    }
    
    /**
     * Randomly returns either 1.0 or -1.0.
     */
    public static func randomSign() -> CGFloat {
        return (arc4random_uniform(2) == 0) ? 1.0 : -1.0
    }
}
