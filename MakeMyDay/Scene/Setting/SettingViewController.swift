//
//  SettingViewController.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/11.
//

import UIKit

class SettingViewController: BaseViewController{
    
    lazy var mainView = SettingView()
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationUI()
    }
    
    override func setNavigationUI() {
        if themeType {
            navigationBarAppearance.backgroundColor = Constants.BaseColor.foreground
            navigationBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        } else {
            navigationBarAppearance.backgroundColor = Constants.BaseColor.foregroundColor
            navigationBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        }

       
        self.navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }
}
