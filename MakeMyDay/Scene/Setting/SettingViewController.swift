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
        navigationBarAppearance.backgroundColor = themeType().foregroundColor
        navigationBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: themeType().whiteBlackUIColor]
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: themeType().whiteBlackUIColor]

       
        self.navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }
}
