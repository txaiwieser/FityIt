//
//  ShapeType+Paths.swift
//  FityIt
//
//  Created by Txai Wieser on 14/03/18.
//  Copyright © 2018 Txai Wieser. All rights reserved.
//

import SpriteKit

extension ShapeType {
    enum Circle {
        private static let radius: CGFloat = 40
        private static let insidePercentage: CGFloat = 0.46
        
        static func path() -> UIBezierPath {
            let size = CGSize(width: 2 * radius, height: 2 * radius)
            let origin = CGPoint(x: -radius, y: -radius)
            return UIBezierPath(ovalIn: CGRect(origin: origin, size: size))
        }
        
        static func spinnerPath(size: CGSize) -> UIBezierPath {
            let newRadius = radius * 1.06
            
            let path = UIBezierPath()
            path.move(to: CGPoint(x: newRadius, y: size.height / 2))
            path.addLine(to: CGPoint(x: size.width / 2, y: size.height / 2))
            path.addLine(to: CGPoint(x: 0, y: -size.height / 2))
            path.addLine(to: CGPoint(x: -size.width / 2, y: size.height / 2))
            path.addLine(to: CGPoint(x: -newRadius, y: size.height / 2))
            
            
            let inside = 2 * newRadius * insidePercentage
            let angle = 2 * acos(1 - inside / newRadius)
            path.addArc(withCenter: CGPoint(x: 0, y: (size.height / 2) + newRadius - inside),
                                  radius: newRadius,
                                  startAngle: .pi + .pi/2 - angle/2,
                                  endAngle: .pi + .pi/2 + angle/2,
                                  clockwise: true)
            path.close()
            return path
        }
        
        static func drawBorder(onPath path: UIBezierPath, size: CGSize) {
            let newRadius = radius * 1.06
            
            path.addLine(to: CGPoint(x: -size.width / 2, y: size.height / 2))
            
            let inside = 2 * newRadius * 0.5
            let angle = 2 * acos(1 - inside/newRadius)
            path.addArc(withCenter: CGPoint(x: 0, y: size.height / 2 + newRadius - inside),
                                  radius: newRadius,
                                  startAngle: .pi + .pi/2 - angle / 2,
                                  endAngle: .pi + .pi/2 + angle / 2,
                                  clockwise: true)
            path.addLine(to: CGPoint(x: size.width / 2, y: size.height / 2))
        }
    }
    
    enum Square {
        private static let length: CGFloat = 66
        private static let insidePercentage: CGFloat = 0.5
        
        static func path() -> UIBezierPath {
            let size = CGSize(width: length, height: length)
            let origin = CGPoint(x: -length/2, y: -length/2)
            return UIBezierPath(rect: CGRect(origin: origin, size: size))
        }
        
        static func spinnerPath(size: CGSize) -> UIBezierPath {
            let newLength = length * 1.072
            let path = UIBezierPath()
            
            path.move(to: CGPoint(x: newLength/2, y: size.height/2))
            path.addLine(to: CGPoint(x: (size.width/2), y: size.height/2))
            path.addLine(to: CGPoint(x: 0, y: -size.height/2))
            path.addLine(to: CGPoint(x: -(size.width/2), y: size.height/2))
            path.addLine(to: CGPoint(x: -newLength/2, y: size.height/2))
            
            path.addLine(to: CGPoint(x: -newLength/2, y: size.height/2 - newLength * insidePercentage))
            path.addLine(to: CGPoint(x: newLength/2, y: size.height/2 - newLength * insidePercentage))
            path.addLine(to: CGPoint(x: newLength/2, y: size.height/2))
            
            path.close()
            return path
        }
        
        static func drawBorder(onPath path: UIBezierPath, size: CGSize) {
            let newLength = length * 1.072

            path.addLine(to: CGPoint(x: -size.width / 2, y: size.height / 2))
            path.addLine(to: CGPoint(x: -newLength / 2, y: size.height / 2))

            path.addLine(to: CGPoint(x: -newLength / 2, y: size.height / 2 - newLength * insidePercentage))
            path.addLine(to: CGPoint(x: newLength / 2, y: size.height / 2 - newLength * insidePercentage))
            path.addLine(to: CGPoint(x: newLength / 2, y: size.height / 2))
        }
    }
    
    enum Triangle {
        private static let base: CGFloat = 90
        private static let height: CGFloat = 80
        private static let insidePercentage: CGFloat = 0.66
        
        static func path() -> UIBezierPath {
            let size = CGSize(width: base, height: height)
            return UIBezierPath(triangleIn: size)
        }
        
        static func spinnerPath(size: CGSize) -> UIBezierPath {
            let v1 = CGVector(dx: base, dy: height / 2)
            let v2 = CGVector(angle: v1.angle)
            let cons = height * insidePercentage / v2.dx
            let v3 = v2 * cons
            let open = 2 * v3.dy * 1.3
            
            let path = UIBezierPath()
            path.move(to: CGPoint(x: open / 2, y: size.height / 2))
            path.addLine(to: CGPoint(x: size.width / 2, y: size.height / 2))
            path.addLine(to: CGPoint(x: 0, y: -size.height / 2))
            path.addLine(to: CGPoint(x: -size.width / 2, y: size.height / 2))
            path.addLine(to: CGPoint(x: -open / 2, y: size.height / 2))
            
            path.addLine(to: CGPoint(x: 0, y: size.height / 2 - height * insidePercentage))
            path.addLine(to: CGPoint(x: open / 2, y: size.height / 2))
            
            path.close()
            return path
        }
        
        static func drawBorder(onPath path: UIBezierPath, size: CGSize) {
            let v1 = CGVector(dx: base, dy: height / 2)
            let v2 = CGVector(angle: v1.angle)
            let const = height * insidePercentage / v2.dx
            let v3 = v2 * const
            let open = 2 * v3.dy * 1.3
            
            path.addLine(to: CGPoint(x: -size.width / 2, y: size.height / 2))
            path.addLine(to: CGPoint(x: -open / 2, y: size.height / 2))
            
            path.addLine(to: CGPoint(x: 0, y: size.height / 2 - height * insidePercentage))
            path.addLine(to: CGPoint(x: open / 2, y: size.height / 2))
        }
    }
    
    enum Pentagon {
        private static let width: CGFloat = 82
        private static let insidePercentage: CGFloat = 0.8
        
        static func path() -> UIBezierPath {
            return UIBezierPath(pentagonWith: width)
        }
        
        static func spinnerPath(size: CGSize) -> UIBezierPath {
            let lenght = width * (sqrt(5) - 1) / 2 * 1.05
            
            let i72: CGFloat = 2 * .pi / 5
            let i54 = (.pi - i72) / 2
            let i36 = .pi - .pi / 2 - i54
            let x = lenght * cos(i36)
            let y = lenght * sin(i36)
            let in1 = x - lenght / 2
            
            let centerHeight = tan(i54) * lenght / 2
            let topHeight = (1 / cos(i54)) * lenght / 2
            let help1 = topHeight - y
            let totalHeight = centerHeight + help1
            
            let in2 = in1 * insidePercentage
            let open = 2 * in2 + lenght * 1.02
            
            let path = UIBezierPath()
            path.move(to: CGPoint(x: open / 2, y: size.height / 2))
            path.addLine(to: CGPoint(x: size.width / 2, y: size.height / 2))
            path.addLine(to: CGPoint(x: 0, y: -size.height / 2))
            path.addLine(to: CGPoint(x: -size.width / 2, y: size.height / 2))
            path.addLine(to: CGPoint(x: -open / 2, y: size.height / 2))
            
            let heightInside = totalHeight * insidePercentage
            path.addLine(to: CGPoint(x: -lenght / 2, y: size.height / 2 - heightInside))
            path.addLine(to: CGPoint(x: lenght / 2, y: size.height / 2 - heightInside))
            path.addLine(to: CGPoint(x: open / 2, y: size.height / 2))
            path.close()
            return path
        }
        
        static func drawBorder(onPath path: UIBezierPath, size: CGSize) {
            let lenght = width * (sqrt(5) - 1) / 2 * 1.05
            
            let i72: CGFloat = 2 * .pi / 5
            let i54 = (.pi - i72) / 2
            let i36 = .pi - .pi / 2 - i54
            let x = lenght * cos(i36)
            let y = lenght * sin(i36)
            let in1 = x - lenght / 2
            
            let centerHeight = tan(i54) * lenght / 2
            let topHeight = (1 / cos(i54)) * lenght / 2
            let help1 = topHeight - y
            let totalHeight = centerHeight + help1
            
            let in2 = in1 * insidePercentage
            let open = 2 * in2 + lenght * 1.02
            
            
            path.addLine(to: CGPoint(x: -size.width / 2, y: size.height / 2))
            path.addLine(to: CGPoint(x: -open / 2, y: size.height / 2))
            
            let heightInside = totalHeight * insidePercentage
            path.addLine(to: CGPoint(x: -lenght / 2, y: size.height / 2 - heightInside))
            path.addLine(to: CGPoint(x: lenght / 2, y: size.height / 2 - heightInside))
            path.addLine(to: CGPoint(x: open / 2, y: size.height / 2))
        }
    }
}
