//
//  AssetImageProvider.swift
//  Domain
//
//  Created by Y on 11/6/25.
//  Copyright © 2025 MakeMyDay. All rights reserved.
//

import SwiftUI

public protocol AssetImageProvider {
    func image(asset: AssetImage) -> UIImage
}
