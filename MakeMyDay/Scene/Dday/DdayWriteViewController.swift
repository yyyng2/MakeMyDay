//
//  DdayWriteViewController.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/11.
//

import UIKit

class DdayWriteViewController: BaseViewController{
    let mainView = DdayWriteView()
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
}
