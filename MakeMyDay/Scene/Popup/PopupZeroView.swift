//
//  PopupZeroView.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/12.
//

import UIKit

class PopupZeroView: BaseView {
    
    let welcomeLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 3
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.text = """
                    \("welcome".localized)
                    \("welcomeTwo".localized)
                    """
        return label
    }()
    
    let imageView: CustomImageView = {
        let view = CustomImageView(frame: .zero)
        view.image = UIImage(named: "day_color")
        return view
    }()
    
    let welcomeLabelTwo: UILabel = {
       let label = UILabel()
        label.numberOfLines = 3
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.text = """
                    Make
                    My
                    Day
                    """
        return label
    }()
    
    override func configure() {
        backgroundColor = .white
        
        [welcomeLabel, imageView, welcomeLabelTwo].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        welcomeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(safeAreaLayoutGuide).multipliedBy(0.3)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide)
        }
        imageView.snp.makeConstraints { make in
            make.center.equalTo(safeAreaLayoutGuide)
            make.width.height.equalTo(100)
        }
        welcomeLabelTwo.snp.makeConstraints { make in
            make.centerY.equalTo(safeAreaLayoutGuide).multipliedBy(1.3)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide)
        }
    }
}
