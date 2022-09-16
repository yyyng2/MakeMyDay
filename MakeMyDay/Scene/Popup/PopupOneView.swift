//
//  PopupOneView.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/13.
//

import UIKit

class PopupOneView: BaseView {
    let welcomeLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 3
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.text = """
                    마음에 드는 테마를 선택해 볼까요?
                    (설정에서 변경 가능합니다.)
                    """
        return label
    }()
    
    let leftButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "circle"), for: .normal)
        button.setImage(UIImage(systemName: "circle.fill"), for: .selected)
        button.tintColor = .gray
        return button
    }()
    
    let leftImage: UIImageView = {
       let view = UIImageView()
        view.image = UIImage(named: "theme_black")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let rightButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "circle"), for: .normal)
        button.setImage(UIImage(systemName: "circle.fill"), for: .selected)
        button.tintColor = .gray
        return button
    }()
    
    let rightImage: UIImageView = {
       let view = UIImageView()
        view.image = UIImage(named: "theme_color")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let doneButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.backgroundColor = .black
        button.setTitle("확인", for: .normal)
        button.tintColor = .white
        return button
    }()
    
    override func configure() {
        backgroundColor = .white
        
        [welcomeLabel, leftImage, leftButton, rightImage, rightButton, doneButton].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        welcomeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(safeAreaLayoutGuide).multipliedBy(0.3)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide)
        }
        
        leftImage.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).multipliedBy(1.3)
            
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.4)
            make.height.equalTo(leftImage.snp.width).multipliedBy(1.5)
            make.centerX.equalTo(safeAreaLayoutGuide).multipliedBy(0.5)
        }
        
        leftButton.snp.makeConstraints { make in
            make.top.equalTo(leftImage.snp.bottom)
            
            make.width.height.equalTo(100)
            make.centerX.equalTo(safeAreaLayoutGuide).multipliedBy(0.5)
        }
        
        rightImage.snp.makeConstraints { make in
            make.top.equalTo(leftImage.snp.top)
            
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.4)
            make.height.equalTo(leftImage.snp.width).multipliedBy(1.5)
            make.centerX.equalTo(safeAreaLayoutGuide).multipliedBy(1.5)
        }
        
        rightButton.snp.makeConstraints { make in
            make.top.equalTo(leftImage.snp.bottom)
            
            make.width.height.equalTo(leftButton)
            make.centerX.equalTo(safeAreaLayoutGuide).multipliedBy(1.5)
        }
        
        doneButton.snp.makeConstraints { make in
            make.top.equalTo(leftButton.snp.bottom).multipliedBy(1.1)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.2)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.1)
        }
    }
}
