//
//  AlarmView.swift
//  MakeMyDay
//
//  Created by Y on 2022/10/03.
//

import UIKit

class AlarmView: BaseView {
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
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.backgroundColor = .clear
        return view
    }()
    
    override func configure() {
        [backgroundView, tableView].forEach {
            addSubview($0)
        }
    }
    override func setConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}
