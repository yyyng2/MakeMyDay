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
    case nickname = "nickname"
    case profileImageBool = "profileImageBool"
    case profileNameBool = "profileNameBool"
    case profileName = "profileName"
    case alarmMon = "alarmMon"
    case alarmMonTime = "alarmMonTime"
    case alarmTue = "alarmTue"
    case alarmTueTime = "alarmTueTime"
    case alarmWed = "alarmWed"
    case alarmWedTime = "alarmWedTime"
    case alarmThu = "alarmThu"
    case alarmThuTime = "alarmThuTime"
    case alarmFri = "alarmFri"
    case alarmFriTime = "alarmFriTime"
    case alarmSat = "alarmSat"
    case alarmSatTime = "alarmSatTime"
    case alarmSun = "alarmSun"
    case alarmSunTime = "alarmSunTime"
}

struct User {
    @UserDefaultsHelper(key: keyEnum.isAppFirstLaunch.rawValue, defaultValue: true)
    static var isAppFirstLaunch: Bool
    
    @UserDefaultsHelper(key: keyEnum.themeType.rawValue, defaultValue: 0)
    static var themeType: Int
    
    @UserDefaultsHelper(key: keyEnum.pickerType.rawValue, defaultValue: 0)
    static var pickerType: Int
    
    @UserDefaultsHelper(key: keyEnum.profileImageBool.rawValue, defaultValue: false)
    static var profileImageBool: Bool
    
    @UserDefaultsHelper(key: keyEnum.profileNameBool.rawValue, defaultValue: false)
    static var profileNameBool: Bool
    
    @UserDefaultsHelper(key: keyEnum.nickname.rawValue, defaultValue: "")
    static var profileName: String
    
    @UserDefaultsHelper(key: keyEnum.alarmMon.rawValue, defaultValue: false)
    static var alarmMon: Bool
    
    @UserDefaultsHelper(key: keyEnum.alarmMonTime.rawValue, defaultValue: "")
    static var alarmMonTime: String
    
    @UserDefaultsHelper(key: keyEnum.alarmTue.rawValue, defaultValue: false)
    static var alarmTue: Bool
    
    @UserDefaultsHelper(key: keyEnum.alarmTueTime.rawValue, defaultValue: "")
    static var alarmTueTime: String
    
    @UserDefaultsHelper(key: keyEnum.alarmWed.rawValue, defaultValue: false)
    static var alarmWed: Bool
    
    @UserDefaultsHelper(key: keyEnum.alarmWedTime.rawValue, defaultValue: "")
    static var alarmWedTime: String
    
    @UserDefaultsHelper(key: keyEnum.alarmThu.rawValue, defaultValue: false)
    static var alarmThu: Bool
    
    @UserDefaultsHelper(key: keyEnum.alarmThuTime.rawValue, defaultValue: "")
    static var alarmThuTime: String
    
    @UserDefaultsHelper(key: keyEnum.alarmFri.rawValue, defaultValue: false)
    static var alarmFri: Bool
    
    @UserDefaultsHelper(key: keyEnum.alarmFriTime.rawValue, defaultValue: "")
    static var alarmFriTime: String
    
    @UserDefaultsHelper(key: keyEnum.alarmSat.rawValue, defaultValue: false)
    static var alarmSat: Bool
    
    @UserDefaultsHelper(key: keyEnum.alarmSatTime.rawValue, defaultValue: "")
    static var alarmSatTime: String
    
    @UserDefaultsHelper(key: keyEnum.alarmSun.rawValue, defaultValue: false)
    static var alarmSun: Bool
    
    @UserDefaultsHelper(key: keyEnum.alarmSunTime.rawValue, defaultValue: "")
    static var alarmSunTime: String
    
}
