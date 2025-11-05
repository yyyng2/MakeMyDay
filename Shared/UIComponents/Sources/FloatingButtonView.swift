//
//  FloatingButtonView.swift
//  UIComponents
//
//  Created by Y on 10/24/25.
//  Copyright © 2025 MakeMyDay. All rights reserved.
//

import SwiftUI

public struct FloatingButtonView: View {
    public var buttonAction: () -> ()
    public var buttonImageName: String
    public var buttonImgaeTintColor: Color
    public var buttonBackgroundColor: Color
    public var buttonBorderColor: Color
    public var buttonBottomPadding: CGFloat
    
    public init(
        buttonAction: @escaping () -> Void,
        buttonImageName: String = "square.and.pencil",
        buttonImgaeTintColor: Color,
        buttonBackgroundColor: Color,
        buttonBorderColor: Color,
        buttonBottomPadding: CGFloat = 12
    ) {
        self.buttonAction = buttonAction
        self.buttonImageName = buttonImageName
        self.buttonImgaeTintColor = buttonImgaeTintColor
        self.buttonBackgroundColor = buttonBackgroundColor
        self.buttonBorderColor = buttonBorderColor
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
                                HoverRoundedRectangleView(
                                    backgroundColor: buttonBackgroundColor,
                                    borderColor: buttonBorderColor
                                )
                                Image(systemName: buttonImageName)
                                    .tint(buttonImgaeTintColor)
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
                                HoverRoundedRectangleView(
                                    backgroundColor: buttonBackgroundColor,
                                    borderColor: buttonBorderColor
                                )
                                Image(systemName: buttonImageName)
                                    .tint(buttonImgaeTintColor)
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
