//
//  ThemeViewController.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/22.
//

import UIKit

class ThemeViewController: BaseViewController {
    let mainView = ThemeView()
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureButton()
    }
    
    override func setNavigationUI() {
        navigationBarAppearance.backgroundColor = themeType().foregroundColor
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: themeType().whiteBlackUIColor]
        navigationBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: themeType().whiteBlackUIColor]
        navigationController?.navigationBar.prefersLargeTitles = true
       
        self.navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }
    
    func configureButton() {
        mainView.leftButton.addTarget(self, action: #selector(leftButtonChanged), for: .touchUpInside)
        mainView.rightButton.addTarget(self, action: #selector(rightButtonChanged), for: .touchUpInside)
        mainView.doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        mainView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
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
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
              let sceneDelegate = windowScene?.delegate as? SceneDelegate
        let viewController = TabBarController()
        
        if !mainView.leftButton.isSelected, !mainView.rightButton.isSelected {
            showAlert(title: "", message: "chooseTheme".localized, buttonTitle: "okay".localized)
        } else if mainView.leftButton.isSelected {
            User.themeType = 0
            sceneDelegate?.window?.rootViewController = UINavigationController(rootViewController: viewController)
            sceneDelegate?.window?.makeKeyAndVisible()
           // transition(vc, transitionStyle: .presentFullNavigation)
        } else {
            User.themeType = 1
            sceneDelegate?.window?.rootViewController = UINavigationController(rootViewController: viewController)
            sceneDelegate?.window?.makeKeyAndVisible()
            //transition(vc, transitionStyle: .presentFullNavigation)
        }
    }
    
    @objc func cancelButtonTapped() {
      dismiss(animated: true)
    }
}
