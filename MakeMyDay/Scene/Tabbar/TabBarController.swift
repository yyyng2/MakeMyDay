//
//  TabBarController.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/11.
//

import UIKit

//var themeType = UserDefaultsHelper.standard.userDefaults.bool(forKey: "theme")


class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.configure()
        }

        self.delegate = self
    }
    
    func configure(){
//        backgroundColor = .clear
        
        let vc1 = MainViewController()
        let vc2 = ScheduleViewController()
        let vc3 = DdayViewController()
        let vc4 = SettingViewController()

        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.clear]
        
        self.tabBar.backgroundColor = themeType().backgroundColor
        self.tabBar.tintColor = themeType().tintColor
        self.tabBar.unselectedItemTintColor = themeType().tintColor
     
        configureTab(vc: vc1, title: "Home", image: themeType().tabBarHomeItem, selectedImage: themeType().tabBarHomeItemSelected)
        configureTab(vc: vc2, title: "Schedule", image: themeType().tabBarScheduleItem, selectedImage: themeType().tabBarScheduleItemSelected)
        configureTab(vc: vc3, title: "D-day", image: themeType().tabBarDdayItem, selectedImage: themeType().tabBarDdayItemSelected)
        configureTab(vc: vc4, title: "Settings", image: themeType().tabBarSettingItem, selectedImage: themeType().tabBarSettingItemSelected)
        
        tabBar.isTranslucent = false
        
        let nav1 = configureNav(vc: vc1)
        let nav2 = configureNav(vc: vc2)
        let nav3 = configureNav(vc: vc3)
        let nav4 = configureNav(vc: vc4)
        
        setViewControllers([nav1, nav2, nav3, nav4], animated: true)
    }
    
    func configureTab(vc: UIViewController, title: String, image: UIImage, selectedImage: UIImage){
        vc.navigationItem.title = title
        vc.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        vc.navigationItem.largeTitleDisplayMode = .always
    }
    
    func configureNav(vc: UIViewController) -> UINavigationController{
        let nav = UINavigationController(rootViewController: vc)
        nav.navigationBar.prefersLargeTitles = true
        return nav
    }
    

    
}
