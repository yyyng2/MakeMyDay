//
//  Transition+Extension.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/10.
//

import UIKit

extension UIViewController{
    enum TransitionStyle{
        case present
        case presentNavigation
        case presentFullNavigation
        case push
        case overFullScreen
    }
    
    func transition<T: UIViewController>(_ viewController: T, transitionStyle: TransitionStyle) {
        
        let navi = UINavigationController(rootViewController: viewController)
        
        switch transitionStyle {
            
        case .present:
            self.present(viewController, animated: true)
            
        case .presentNavigation:
            self.present(navi, animated: true)
        
        case .presentFullNavigation:
            navi.modalPresentationStyle = .fullScreen
            self.present(navi, animated: true) 
            
        case .push:
            self.navigationController?.pushViewController(navi, animated: true)
            
        case .overFullScreen:
            navi.modalPresentationStyle = .overFullScreen
            self.present(navi, animated: true)
     
        }
        

    }
    
}
