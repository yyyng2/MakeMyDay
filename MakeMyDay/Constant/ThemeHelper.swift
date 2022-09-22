//
//  ThemeHelper.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/20.
//

import UIKit

enum ThemeType {
    case blackTheme
    case colorfulTheme
    
    var foregroundColor: UIColor {
           switch self {
           case .blackTheme:
               return Constants.BaseColor.foreground!
           case .colorfulTheme:
               return Constants.BaseColor.foregroundColor!
           }
       }
       
    var objectBackgroundColor: UIColor {
        switch self {
        case .blackTheme:
            return .black
        case .colorfulTheme:
            return .white
        }
    }
    
    var whiteBlackBorderColor: CGColor {
        switch self {
        case .blackTheme:
            return UIColor.white.cgColor
        case .colorfulTheme:
            return UIColor.black.cgColor
        }
    }
    
    var whiteBlackUIColor: UIColor {
        switch self {
        case .blackTheme:
            return UIColor.white
        case .colorfulTheme:
            return UIColor.black
        }
    }
    
    var calendarTintColor: UIColor {
        switch self {
        case .blackTheme:
            return UIColor.white
        case .colorfulTheme:
            return UIColor.black
        }
    }
    
    var calendarHeaderColor: UIColor {
        switch self {
        case .blackTheme:
            return .white
        case .colorfulTheme:
            return .black
        }
    }
    
    var calendarSelectionColor: UIColor {
        switch self {
        case .blackTheme:
            return UIColor.systemGray2
        case .colorfulTheme:
            return UIColor.black
        }
    }
    var backgroundImage: UIImage {
        switch self {
           case .blackTheme:
               return UIImage(named: "background_black")!
           case .colorfulTheme:
               return UIImage(named: "background_color")!
           }
       }
       
       var tintColor: UIColor {
           switch self {
           case .blackTheme:
               return .white
           case .colorfulTheme:
               return .black
           }
       }
       
       var bubbleShort: UIImage {
           switch self {
           case .blackTheme:
               return UIImage(named: "bubble_black_short")!
           case .colorfulTheme:
               return UIImage(named: "bubble_white_short")!
           }
       }
    
    var bubbleLong: UIImage {
        switch self {
        case .blackTheme:
            return UIImage(named: "bubble_black_long")!
        case .colorfulTheme:
            return UIImage(named: "bubble_white_long")!
        }
    }
    
    var bubbleMini: UIImage {
        switch self {
        case .blackTheme:
            return UIImage(named: "bubble_black_mini")!
        case .colorfulTheme:
            return UIImage(named: "bubble_white_mini")!
        }
    }
    
        var backgroundColor: UIColor {
            switch self {
            case .blackTheme:
                return .systemGray6
            case .colorfulTheme:
                return Constants.BaseColor.foregroundColor!
            }
        }
    
    var tabBarHomeItem: UIImage {
        switch self {
        case .blackTheme:
            return UIImage(named: "home_white")!
        case .colorfulTheme:
            return UIImage(named: "home_black")!
        }
    }
    
    var tabBarHomeItemSelected: UIImage {
        switch self {
        case .blackTheme:
            return UIImage(named: "home_white_fill")!
        case .colorfulTheme:
            return UIImage(named: "home_black_fill")!
        }
    }
    
    var tabBarScheduleItem: UIImage {
        switch self {
        case .blackTheme:
            return UIImage(named: "schedule_white")!
        case .colorfulTheme:
            return UIImage(named: "schedule_black")!
        }
    }
    
    var tabBarScheduleItemSelected: UIImage {
        switch self {
        case .blackTheme:
            return UIImage(named: "schedule_white_fill")!
        case .colorfulTheme:
            return UIImage(named: "schedule_black_fill")!
        }
    }
    
    var tabBarDdayItem: UIImage {
        switch self {
        case .blackTheme:
            return UIImage(named: "dday_white")!
        case .colorfulTheme:
            return UIImage(named: "dday_black")!
        }
    }
    
    var tabBarDdayItemSelected: UIImage {
        switch self {
        case .blackTheme:
            return UIImage(named: "dday_white_fill")!
        case .colorfulTheme:
            return UIImage(named: "dday_black_fill")!
        }
    }
    
    var tabBarSettingItem: UIImage {
        switch self {
        case.blackTheme:
            return UIImage(named: "setting_white")!
        case .colorfulTheme:
            return UIImage(named: "setting_black")!
        }
    }
    
    var tabBarSettingItemSelected: UIImage {
        switch self {
        case.blackTheme:
            return UIImage(named: "setting_white_fill")!
        case .colorfulTheme:
            return UIImage(named: "setting_black_fill")!
        }
    }
    
    var profileImage: UIImage {
        switch self {
        case .blackTheme:
            return UIImage(named: "day_white.png")!
        case .colorfulTheme:
            return UIImage(named: "day_color.png")!
        }
    }
    
    var countTextColor: UIColor {
        switch self {
        case .blackTheme:
            return .systemMint
        case .colorfulTheme:
            return .systemBlue
        }
    }
    
}

func themeType() -> ThemeType {
    switch UserDefaults.standard.integer(forKey: "theme") {
    case 0:
        return ThemeType.blackTheme
    case 1:
        return ThemeType.colorfulTheme
    default:
        return ThemeType.blackTheme
    }
}
