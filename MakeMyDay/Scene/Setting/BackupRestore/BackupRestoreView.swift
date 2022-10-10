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
    
    let infoLabel: CustomLabel = {
        let label = CustomLabel()
        label.text = """
                    \("BRInfo".localized)
                    \("BRInfoTwo".localized)
                    """
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .heavy)
      
        return label
    }()
    
    let backupButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = themeType().tintColor
        
        let button = UIButton()
        button.configuration = config
        button.setTitle("backup".localized, for: .normal)
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
        button.setTitle("restore".localized, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.backgroundColor = themeType().foregroundColor
        return button
    }()
    
    override func configure() {
        [backgroundView, infoLabel, backupButton, restoreButton].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        infoLabel.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(backupButton.snp.top).offset(-70)
        }
        backupButton.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.centerY.equalTo(safeAreaLayoutGuide).multipliedBy(0.8)
        }
        restoreButton.snp.makeConstraints { make in
            make.top.equalTo(backupButton.snp.bottom).offset(50)
            make.centerX.equalTo(backupButton)
        }
    }
}
