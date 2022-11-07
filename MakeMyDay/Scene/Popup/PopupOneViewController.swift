//
//  PopupOneViewController.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/13.
//

import UIKit

class PopupOneViewController: BaseViewController {
    let mainView = PopupOneView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureButton()

    }
    
    func configureButton() {
        mainView.leftButton.addTarget(self, action: #selector(leftButtonChanged), for: .touchUpInside)
        mainView.rightButton.addTarget(self, action: #selector(rightButtonChanged), for: .touchUpInside)
        mainView.doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
    }

    @objc func leftButtonChanged() {
        DispatchQueue.main.async {
            if self.mainView.rightButton.isSelected == true {
                self.mainView.rightButton.isSelected = !self.mainView.rightButton.isSelected
            }
            self.mainView.leftButton.isSelected = !self.mainView.leftButton.isSelected
        }
    }
    
    @objc func rightButtonChanged() {
        DispatchQueue.main.async {
            if self.mainView.leftButton.isSelected == true {
                self.mainView.leftButton.isSelected = !self.mainView.leftButton.isSelected
            }
            self.mainView.rightButton.isSelected = !self.mainView.rightButton.isSelected
        }
    }
    
    @objc func doneButtonTapped() {
        
        let vc = TabBarController()
        
        if !mainView.leftButton.isSelected, !mainView.rightButton.isSelected {
            showAlert(title: "", message: "chooseTheme".localized, buttonTitle: "okay".localized)
        } else if mainView.leftButton.isSelected {
            User.themeType = 0
            transition(vc, transitionStyle: .presentFullNavigation) 
        } else {
            User.themeType = 1
            transition(vc, transitionStyle: .presentFullNavigation)
        }
    }
    
}
