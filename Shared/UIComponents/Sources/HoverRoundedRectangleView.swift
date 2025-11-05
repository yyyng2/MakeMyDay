//
//  HoverRoundedRectangleView.swift
//  UIComponents
//
//  Created by Y on 5/1/25.
//  Copyright © 2025 MakeMyDay. All rights reserved.
//

import SwiftUI

public struct HoverRoundedRectangleView: View {
    public var backgroundColor: Color
    public var borderColor: Color
    public init (
        backgroundColor: Color,
        borderColor: Color
    ) {
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
    }
    public var body: some View {
        if #available(iOS 26.0, *) {
            RoundedRectangle(cornerRadius: 10)
                .fill(.clear)
                .frame(width: 50, height: 50)
        } else {
            RoundedRectangle(cornerRadius: 10)
//                .fill(ResourcesAsset.Assets.baseForeground.swiftUIColor)
                .fill(backgroundColor)
                .strokeBorder(borderColor, lineWidth: 1)
//                .strokeBorder(ResourcesAsset.Assets.baseBorder.swiftUIColor, lineWidth: 1)
                .frame(width: 50, height: 50)
        }
    }
}
