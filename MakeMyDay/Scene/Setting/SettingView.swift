//
//  SettingView.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/11.
//

import UIKit

class SettingView: BaseView {
    
    let backgroundView: BackgroundImageView = {
        let view = BackgroundImageView(frame: .zero)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        [backgroundView].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}
