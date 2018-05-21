import UIKit

extension Int {
    /**
     * Returns a random integer in the specified range.
     */
    public static func random(within range: Range<Int>) -> Int {
        return Int(arc4random_uniform(UInt32(range.upperBound - range.lowerBound))) + range.lowerBound
    }
}
