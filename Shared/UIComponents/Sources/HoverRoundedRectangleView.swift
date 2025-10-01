//
//  HoverRoundedRectangleView.swift
//  UIComponents
//
//  Created by Y on 5/1/25.
//  Copyright © 2025 MakeMyDay. All rights reserved.
//

import SwiftUI
import Resources

public struct HoverRoundedRectangleView: View {
    public init () {}
    public var body: some View {
        if #available(iOS 26.0, *) {
            RoundedRectangle(cornerRadius: 10)
                .fill(.clear)
                .frame(width: 50, height: 50)
        } else {
            RoundedRectangle(cornerRadius: 10)
                .fill(ResourcesAsset.Assets.baseForeground.swiftUIColor)
                .strokeBorder(ResourcesAsset.Assets.baseBorder.swiftUIColor, lineWidth: 1)
                .frame(width: 50, height: 50)
        }
    }
}
