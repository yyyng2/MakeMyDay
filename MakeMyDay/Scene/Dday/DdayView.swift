//
//  DdayView.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/11.
//

import UIKit

class DdayView: BaseView {
    
    let backgroundView: BackgroundImageView = {
        let view = BackgroundImageView(frame: .zero)
        return view
    }()
    
    let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.backgroundColor = .clear
        return view
    }()
    
    let writeButton: CustomWriteButton = {
        let button = CustomWriteButton(frame: .zero)
        button.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        let pointSize: CGFloat = 15
        let imageConfig = UIImage.SymbolConfiguration(pointSize: pointSize)
        var config = UIButton.Configuration.plain()
        button.configuration = config
        button.backgroundColor = themeType().foregroundColor
        button.tintColor = themeType().tintColor
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        [backgroundView, tableView, writeButton].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        writeButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-20)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.145)
            make.height.equalTo(writeButton.snp.width)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-8)
        }
    }
}
