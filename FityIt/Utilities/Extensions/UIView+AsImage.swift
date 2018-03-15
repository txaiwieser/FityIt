//
//  UIView+AsImage.swift
//  FityIt
//
//  Created by Txai Wieser on 15/03/18.
//  Copyright © 2018 Txai Wieser. All rights reserved.
//

import UIKit

enum Resize {
    case current
    case size(CGSize)
    case width(CGFloat)
    case height(CGFloat)
    
    func calculateNewSize(fromImage: UIImage?) -> CGSize? {
        switch self {
        case .current:
            return nil
        case .size(let size):
            return size
        case .width(let width):
            guard let fromImage = fromImage else { return nil }
            
            let oldWidth = fromImage.size.width
            let scaleFactor = width / oldWidth
            
            let newHeight = fromImage.size.height * scaleFactor
            let newWidth = oldWidth * scaleFactor
            
            return CGSize(width: newWidth, height: newHeight)
        case .height(let height):
            guard let fromImage = fromImage else { return nil }
            
            let oldHeight = fromImage.size.height
            let scaleFactor = height / oldHeight
            
            let newWidth = fromImage.size.width * scaleFactor
            let newHeight = oldHeight * scaleFactor
            
            return CGSize(width: newWidth, height: newHeight)
        }
    }
}

extension UIView {
    func asImage(_ resize: Resize) -> UIImage? {
        let size: CGSize
        if case let .size(re_size) = resize {
            size = re_size
        } else {
            size = self.frame.size
        }
        
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { rendererContext in
            drawHierarchy(in: CGRect(origin: .zero, size: size), afterScreenUpdates: true)
        }
    }
}
