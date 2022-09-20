//
//  UserDefaultsHelper.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/12.
//

import UIKit

@propertyWrapper struct UserDefaultsHelper<T> {
    
    private var key: String
    private let defaultValue: T
  
    
    init(key: String, defaultValue: T) {
          self.key = key
          self.defaultValue = defaultValue
      }
    
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }

}

enum keyEnum: String {
    case isAppFirstLaunch = "isAppFirstLaunch"
    case themeType = "theme"
    case pickerType = "picker"
}

struct User {
    @UserDefaultsHelper(key: keyEnum.isAppFirstLaunch.rawValue, defaultValue: true)
    static var isAppFirstLaunch: Bool
    
    @UserDefaultsHelper(key: keyEnum.themeType.rawValue, defaultValue: 0)
    static var themeType: Int
    
    @UserDefaultsHelper(key: keyEnum.pickerType.rawValue, defaultValue: true)
    static var pickerType: Bool
}
