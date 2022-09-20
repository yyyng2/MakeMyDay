//
//  TabBarController.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/11.
//

import UIKit

//var themeType = UserDefaultsHelper.standard.userDefaults.bool(forKey: "theme")


class TabBarController: UITabBarController, UITabBarControllerDelegate{
    
    let vc1 = MainViewController()
    let vc2 = ScheduleViewController()
    let vc3 = DdayViewController()
    let vc4 = SettingViewController()
    
    override func loadView() {
        super.loadView()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.configure()
        }
        
        self.view.backgroundColor = .clear
        self.delegate = self
    }
    
    func configure(){

        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.clear]
        
        
        self.tabBar.backgroundColor = themeType().backgroundColor
        self.tabBar.tintColor = themeType().tintColor
        self.tabBar.unselectedItemTintColor = themeType().tintColor
        configureTab(vc: vc1, title: "Home", image: themeType().tabBarHomeItem, selectedImage: themeType().tabBarHomeItemSelected)
        configureTab(vc: vc2, title: "Schedule", image: themeType().tabBarScheduleItem, selectedImage: themeType().tabBarScheduleItemSelected)
        configureTab(vc: vc3, title: "D-day", image: themeType().tabBarDdayItem, selectedImage: themeType().tabBarDdayItemSelected)
        configureTab(vc: vc4, title: "Setting", image: themeType().tabBarSettingItem, selectedImage: themeType().tabBarSettingItemSelected)
        
//        if User.themeType {
//            self.tabBar.backgroundColor = .systemGray6
//            self.tabBar.tintColor = .white
//            self.tabBar.unselectedItemTintColor = .white
//            self.configureTab(vc: self.vc1, title: "Home", image: "home_white", selectedImage: "home_white_fill")
//            self.configureTab(vc: self.vc2, title: "Schedule", image: "schedule_white", selectedImage: "schedule_white_fill")
//            self.configureTab(vc: self.vc3, title: "D-day", image: "dday_white", selectedImage: "dday_white_fill")
//            self.configureTab(vc: self.vc4, title: "Setting", image: "setting_white", selectedImage: "setting_white_fill")
//        } else {
//            self.tabBar.backgroundColor = Constants.BaseColor.foregroundColor
//            self.tabBar.unselectedItemTintColor = .black
//            self.tabBar.tintColor = .black
//            self.configureTab(vc: self.vc1, title: "Home", image: "home_black", selectedImage: "home_black_fill")
//            self.configureTab(vc: self.vc2, title: "Schedule", image: "schedule_black", selectedImage: "schedule_black_fill")
//            self.configureTab(vc: self.vc3, title: "D-day", image: "dday_black", selectedImage: "dday_black_fill")
//            self.configureTab(vc: self.vc4, title: "Setting", image: "setting_black", selectedImage: "setting_black_fill")
//        }
        
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
