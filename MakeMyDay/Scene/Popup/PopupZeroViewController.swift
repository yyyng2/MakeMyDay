//
//  PopupZeroViewController.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/12.
//

import UIKit

class PopupZeroViewController: BaseViewController {
    let mainView = PopupZeroView()
    
    override func loadView() {
        self.view = mainView
    }

}
