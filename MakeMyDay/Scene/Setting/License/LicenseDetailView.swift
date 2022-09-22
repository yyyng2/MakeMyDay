//
//  LicenseDetailView.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/22.
//

import UIKit

class LicenseDetailView: BaseView {
    let textView: UITextView = {
       let view = UITextView()
        view.backgroundColor = themeType().backgroundColor
        view.textColor = themeType().tintColor
        return view
    }()
    
    override func configure() {
        addSubview(textView)
    }
    
    override func setConstraints() {
        textView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}
