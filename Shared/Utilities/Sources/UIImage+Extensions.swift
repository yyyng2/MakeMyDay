//
//  UIImage+Extensions.swift
//  Utilities
//
//  Created by Y on 6/10/25.
//  Copyright © 2025 MakeMyDay. All rights reserved.
//

import SwiftUI

extension UIImage {
    public func resizedWithAspectRatio(maxSize: CGFloat) -> UIImage {
        let size = self.size
        let ratio = min(maxSize / size.width, maxSize / size.height)
    
        if ratio >= 1.0 {
            return self
        }
        
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        let renderer = UIGraphicsImageRenderer(size: newSize)
        
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}
