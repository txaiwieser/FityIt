import Foundation

public func delay(_ delay: Double, closure: @escaping (() -> Void)) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: closure)
}
