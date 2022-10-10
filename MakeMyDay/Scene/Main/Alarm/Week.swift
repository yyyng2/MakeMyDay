//
//  Week.swift
//  MakeMyDay
//
//  Created by Y on 2022/10/03.
//

import Foundation

struct DaysList {
    var dayName: String
    var dayAlarm: Bool
    var dayAlarmTime: String
    var dayNum: Int
}

struct DayInfo {
    let week: [DaysList] = [
        DaysList(dayName: "mon".localized, dayAlarm: User.alarmMon, dayAlarmTime: User.alarmMonTime, dayNum: 2),
        DaysList(dayName: "tue".localized, dayAlarm: User.alarmTue, dayAlarmTime: User.alarmTueTime, dayNum: 3),
        DaysList(dayName: "wed".localized, dayAlarm: User.alarmWed, dayAlarmTime: User.alarmWedTime, dayNum: 4),
        DaysList(dayName: "thu".localized, dayAlarm: User.alarmThu, dayAlarmTime: User.alarmThuTime, dayNum: 5),
        DaysList(dayName: "fri".localized, dayAlarm: User.alarmFri, dayAlarmTime: User.alarmFriTime, dayNum: 6),
        DaysList(dayName: "sat".localized, dayAlarm: User.alarmSat, dayAlarmTime: User.alarmSatTime, dayNum: 7),
        DaysList(dayName: "sun".localized, dayAlarm: User.alarmSun, dayAlarmTime: User.alarmSunTime, dayNum: 1)
        ]
    }
