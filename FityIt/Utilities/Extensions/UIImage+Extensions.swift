//
//  UIImage+Extensions.swift
//  FityIt
//
//  Created by Txai Wieser on 14/03/18.
//  Copyright © 2018 Txai Wieser. All rights reserved.
//

import UIKit

extension UIImage {
    static func circle(withRadius radius: CGFloat, color: UIColor) -> UIImage {
        let size = CGSize(width: 2 * radius + 2, height: 2 * radius + 2)
        
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            let context = rendererContext.cgContext
            context.setFillColor(color.cgColor)
            context.setStrokeColor(color.cgColor)
            context.setLineWidth(1)
            context.fillEllipse(in: CGRect(origin: .zero, size: size))
        }
    }
    
    static func square(withlength length: CGFloat, color: UIColor) -> UIImage {
        let size = CGSize(width: length + 2, height: length + 2)
        
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            let context = rendererContext.cgContext
            context.setFillColor(color.cgColor)
            context.setStrokeColor(color.cgColor)
            context.setLineWidth(1)
            context.fill(CGRect(origin: .zero, size: size))
        }
    }
    
    static func pentagon(withWidth width: CGFloat, color: UIColor) -> UIImage {
        let size = CGSize(width: width + 2, height: width + 2)
        
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            let context = rendererContext.cgContext
            context.translateBy(x: 0, y: size.height/2)
            context.rotate(by: .pi)
            context.translateBy(x: -size.width/2, y: 0)
            
            let path = UIBezierPath(pentagonWith: width)
            color.setFill()
            path.fill()
        }
    }
    
    static func triangle(withSize size: CGSize, color: UIColor) -> UIImage {
        
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            let context = rendererContext.cgContext
            context.translateBy(x: 0, y: size.height/2)
            context.rotate(by: .pi)
            context.translateBy(x: -size.width/2, y: 0)
            
            let path = UIBezierPath(triangleIn: size)
            color.setFill()
            path.fill()
        }
    }
    
    static func radialGradient(size: CGSize, colors: [UIColor]) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            let context = rendererContext.cgContext
            let count = colors.count
            let locations: [CGFloat] = (0..<count).map { CGFloat($0) / CGFloat(count-1) }
            let colorsArray = colors.map { $0.cgColor }
            let colorspace = CGColorSpaceCreateDeviceRGB()
            let gradient = CGGradient(colorsSpace: colorspace,
                                      colors: colorsArray as CFArray,
                                      locations: locations)!
            
            let outerRadius = sqrt(pow(size.width/2, 2) + pow(size.height/2, 2))
            context.drawRadialGradient(gradient,
                                       startCenter: CGPoint(x: size.width/2, y: size.height/2),
                                       startRadius: 0,
                                       endCenter: CGPoint(x: size.width/2, y: size.height/2),
                                       endRadius: outerRadius + 4,
                                       options: CGGradientDrawingOptions(rawValue: 0))
        }
    }
    
    static func linearGradient(size: CGSize, colors: [UIColor]) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            let context = rendererContext.cgContext
            let count = colors.count
            let locations: [CGFloat] = (0..<count).map { CGFloat($0) / CGFloat(count-1) }
            let colorsArray = colors.map { $0.cgColor }
            let colorspace = CGColorSpaceCreateDeviceRGB()
            let gradient = CGGradient(colorsSpace: colorspace,
                                      colors: colorsArray as CFArray,
                                      locations: locations)!
            
            context.drawLinearGradient(gradient,
                                       start: .zero,
                                       end: CGPoint(x: size.width, y: 0),
                                       options: CGGradientDrawingOptions(rawValue: 0))
        }
    }
}
