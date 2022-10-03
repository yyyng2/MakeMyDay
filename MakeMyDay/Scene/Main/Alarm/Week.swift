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
        DaysList(dayName: "Mon", dayAlarm: User.alarmMon, dayAlarmTime: User.alarmMonTime, dayNum: 2),
        DaysList(dayName: "Tue", dayAlarm: User.alarmTue, dayAlarmTime: User.alarmTueTime, dayNum: 3),
        DaysList(dayName: "Wed", dayAlarm: User.alarmWed, dayAlarmTime: User.alarmWedTime, dayNum: 4),
        DaysList(dayName: "Thu", dayAlarm: User.alarmThu, dayAlarmTime: User.alarmThuTime, dayNum: 5),
        DaysList(dayName: "Fri", dayAlarm: User.alarmFri, dayAlarmTime: User.alarmFriTime, dayNum: 6),
        DaysList(dayName: "Sat", dayAlarm: User.alarmSat, dayAlarmTime: User.alarmSatTime, dayNum: 7),
        DaysList(dayName: "Sun", dayAlarm: User.alarmSun, dayAlarmTime: User.alarmSunTime, dayNum: 1)
        ]
    }
