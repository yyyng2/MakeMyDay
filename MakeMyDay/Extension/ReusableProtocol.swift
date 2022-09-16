//
//  ReusableProtocol.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/10.
//

import UIKit

protocol ReusableViewProtocol: AnyObject{
    static var reuseIdentifier: String{ get }
}

extension UIViewController: ReusableViewProtocol{
    static var reuseIdentifier: String{
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableViewProtocol{
    static var reuseIdentifier: String{
        return String(describing: self)
    }
}
