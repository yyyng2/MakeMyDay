//
//  MainView.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/10.
//

import UIKit

class MainView: BaseView {

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
    
}
