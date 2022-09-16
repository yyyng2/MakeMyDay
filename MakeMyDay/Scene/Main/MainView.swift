//
//  MainView.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/10.
//

import UIKit

class MainView: BaseView{

    lazy var backgroundView: BackgroundImageView = {
        let view = BackgroundImageView(frame: .zero)
        return view
    }()
    
    let dateLabel: CustomLabel = {
        let label = CustomLabel(frame: .zero)
  
        label.text = "0000년 00월 00일 오전 00:00"
        label.font = .systemFont(ofSize: 13)
        label.textAlignment = .center
        return label
    }()
    
    let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.backgroundColor = .clear
        view.separatorColor = .clear
        return view
    }()
    
    override func configure() {
        
        [backgroundView, dateLabel, tableView].forEach {
            self.addSubview($0)
        }
    }
    override func setConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom)
            make.leading.trailing.bottom.equalTo(safeAreaLayoutGuide)
        }

    }


//
//    let dateLabel: CustomLabel = {
//        let label = CustomLabel(frame: .zero)
//        if themeType {
//            label.textColor = .white
//        } else {
//            label.textColor = .black
//        }
//
//        label.text = "0000년 00월 00일 오전 00:00"
//        label.font = .systemFont(ofSize: 13)
//        label.textAlignment = .center
//        return label
//    }()
//
//    let firstBubbleView: CustomImageView = {
//        let view = CustomImageView(frame: .zero)
//
//        if themeType {
//            view.image = UIImage(named: "bubble_black_short.png")
//        } else {
//            view.image = UIImage(named: "bubble_white_short.png")
//        }
//
//        return view
//    }()
//
//    let firstBubbleLabel: CustomLabel = {
//        let label = CustomLabel(frame: .zero)
//
//        if themeType {
//            label.textColor = .white
//        } else {
//            label.textColor = .black
//        }
//
//        label.text = "좋은 하루보내세요."
//        label.textAlignment = .center
//
//        label.font = .boldSystemFont(ofSize: 16)
//        return label
//    }()
//
//    let secondBubbleView: CustomImageView = {
//        let view = CustomImageView(frame: .zero)
//        if themeType {
//            view.image = UIImage(named: "bubble_black_large.png")
//        } else {
//            view.image = UIImage(named: "bubble_white_large.png")
//        }
//
//        return view
//    }()
//
//
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.configure()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func configure() {
//
//        if themeType {
//            self.backgroundColor = .white
//        } else {
//            self.backgroundColor = .black
//        }
//
//        [backgroundView, dateLabel, firstBubbleView, firstBubbleLabel, secondBubbleView].forEach {
//            addSubview($0)
//        }
//
//    }
//
//    override func setConstraints() {
//
//        backgroundView.snp.makeConstraints { make in
//            make.edges.equalTo(safeAreaLayoutGuide)
//        }
//
//        dateLabel.snp.makeConstraints { make in
//            make.top.equalTo(safeAreaLayoutGuide)
//            make.centerX.equalTo(safeAreaLayoutGuide)
//            make.width.equalTo(safeAreaLayoutGuide)
//        }
//
//        firstBubbleView.snp.makeConstraints { make in
//            make.top.equalTo(dateLabel.snp.bottom).offset(12)
//            make.width.equalToSuperview().multipliedBy(0.8)
//            make.height.equalToSuperview().multipliedBy(0.09)
//        }
//
//        firstBubbleLabel.snp.makeConstraints { make in
//            make.centerX.equalTo(firstBubbleView).multipliedBy(0.7)
//            make.centerY.equalTo(firstBubbleView)
//            make.width.equalTo(firstBubbleView).multipliedBy(0.8)
//            make.height.equalToSuperview().multipliedBy(0.16)
//        }
//
//        secondBubbleView.snp.makeConstraints { make in
//            make.top.equalTo(firstBubbleView.snp.bottom).offset(12)
//            make.width.equalToSuperview().multipliedBy(0.6)
//            make.height.equalToSuperview().multipliedBy(0.15)
//        }
//
//    }
    
}
