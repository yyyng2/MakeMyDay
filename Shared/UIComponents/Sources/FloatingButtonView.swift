//
//  FloatingButtonView.swift
//  UIComponents
//
//  Created by Y on 10/24/25.
//  Copyright © 2025 MakeMyDay. All rights reserved.
//

import SwiftUI
import Resources

public struct FloatingButtonView: View {
    public var buttonAction: () -> ()
    public var buttonImageName: String
    public var buttonBottomPadding: CGFloat
    
    public init(
        buttonAction: @escaping () -> Void,
        buttonImageName: String = "square.and.pencil",
        buttonBottomPadding: CGFloat = 12
    ) {
        self.buttonAction = buttonAction
        self.buttonImageName = buttonImageName
        self.buttonBottomPadding = buttonBottomPadding
    }
    
    public var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                if #available(iOS 26.0, *) {
                    Button(
                        action: {
                            buttonAction()
                        },
                        label: {
                            ZStack {
                                HoverRoundedRectangleView()
                                Image(systemName: buttonImageName)
                                    .tint(Color(ResourcesAsset.Assets.baseFontColor.color))
                            }
                        }
                    )
                    .glassEffect()
                } else {
                    Button(
                        action: {
                            buttonAction()
                        },
                        label: {
                            ZStack {
                                HoverRoundedRectangleView()
                                Image(systemName: buttonImageName)
                                    .tint(Color(ResourcesAsset.Assets.baseFontColor.color))
                            }
                        }
                    )
                }
            }
        }
        .padding(.trailing, 40)
        .padding(.bottom, buttonBottomPadding)
    }
}
