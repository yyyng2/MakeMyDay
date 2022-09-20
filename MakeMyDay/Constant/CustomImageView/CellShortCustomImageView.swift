//
//  CellCustomImageView.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/17.
//

import UIKit

class CellShortCustomImageView: UIImageView {
    
    enum ImageType {
        case bubbleBlackShort
        case bubbleWhiteShort
    }
    
//    func selectImage(imageType: ImageType) -> UIImage {
//        switch imageType {
//        case .bubbleBlackShort:
//            return UIImage(named: "bubble_black_short")!
//        case .bubbleWhiteShort:
//            return UIImage(named: "bubble_white_short")!
//        }
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        configureBackgroundImage()
     
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureBackgroundImage() {
        image = themeType().bubbleShort
    }
    
}
