//
//  LicenseView.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/22.
//

import UIKit

class LicenseView: BaseView {
    let backgroundView: BackgroundImageView = {
        let view = BackgroundImageView(frame: .zero)
        return view
    }()
    
    let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.backgroundColor = .clear
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
        backgroundColor = themeType().foregroundColor
        
        [backgroundView, tableView].forEach {
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
    }
}
