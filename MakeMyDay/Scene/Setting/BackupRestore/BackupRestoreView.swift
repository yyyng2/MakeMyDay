//
//  BackupRestoreView.swift
//  MakeMyDay
//
//  Created by Y on 2022/10/05.
//

import UIKit

class BackupRestoreView: BaseView {
    
    lazy var backgroundView: BackgroundImageView = {
        let view = BackgroundImageView(frame: .zero)
        return view
    }()
    
    let backupButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = themeType().tintColor
        
        let button = UIButton()
        button.configuration = config
        button.setImage(UIImage(systemName: "safari.fill"), for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.backgroundColor = themeType().foregroundColor
        return button
    }()
    
    let restoreButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = themeType().tintColor
        
        let button = UIButton()
        button.configuration = config
        button.setImage(UIImage(systemName: "safari"), for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.backgroundColor = themeType().foregroundColor
        return button
    }()
    
    override func configure() {
        [backgroundView, backupButton, restoreButton].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        backupButton.snp.makeConstraints { make in
            make.center.equalTo(safeAreaLayoutGuide)
        }
        restoreButton.snp.makeConstraints { make in
            make.top.equalTo(backupButton.snp.bottom)
            make.centerX.equalTo(backupButton)
        }
    }
}
