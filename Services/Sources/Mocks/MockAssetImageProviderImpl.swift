//
//  MockAssetImageProviderImpl.swift
//  Services
//
//  Created by Y on 11/6/25.
//  Copyright © 2025 MakeMyDay. All rights reserved.
//

import SwiftUI
import Domain

public final class MockAssetImageProviderImpl: AssetImageProvider {
    public var stubbedImages: [AssetImage: UIImage] = [:]
    
    public init() {}

    public func image(asset: AssetImage) -> UIImage {
        if let stubbedImage = stubbedImages[asset] {
            return stubbedImage
        }

        return MockAssetImageProviderImpl.dummyWhiteImage(image: UIImage())
    }
    
    static func dummyWhiteImage(image: UIImage) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        UIColor.white.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? UIImage()
    }
    
    static func dummyImage(image: UIImage, color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? UIImage()
    }
}
