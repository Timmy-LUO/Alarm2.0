//
//  Alarm.swift
//  Alarm2.0
//
//  Created by 羅承志 on 2022/2/25.
//

import Foundation

struct Alarm {
    var alarms: [Alarm] = []
    
    var date: Date = Date()
    var label: String = "鬧鐘"
    var isOn: Bool = true
    var selectDay: Set<Day> = []
    var modeSelection: ModeSelection = .add
    
    var repeatString: String {
        switch selectDay {
        case [.mon, .tue, .wed, .thu, .fri]:
            return "平日"
        case [.sun, .sat]:
            return "週末"
        case [.mon, .tue, .wed, .thu, .fri, .sat, .sun]:
            return "每天"
        case []:
            return "永不"
        default:
            return selectDay
                .sorted(by: { $0.rawValue < $1.rawValue })
                .map({ $0.detail })
                .joined(separator: " ")
        }
    }
    
    func appearTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        let alarmTime = formatter.string(from: date)
        return alarmTime
    }
    
    func appearAmPm() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "a"
        let alarmAmPm = formatter.string(from: date)
        if alarmAmPm == "AM" {
            return "上午"
        } else {
            return "下午"
        }
    }
}

// MARK: - Enum
enum ModeSelection: String, CaseIterable {
    case add, edit
    
    var title: String {
        switch self {
        case .add:
            return "加入鬧鐘"
        case .edit:
            return "編輯鬧鐘"
        }
    }
}

enum AddCellTitle: String, CaseIterable {
    case rep, tag, sound, snooze
    
    var text: String {
        switch self {
        case .rep:
            return "重複"
        case .tag:
            return "標籤"
        case .sound:
            return "提示音"
        case .snooze:
            return "稍後提醒"
        }
    }
}

enum Day: Int, CaseIterable {
    case sun, mon, tue, wed, thu, fri, sat
    
    var text: String {
        switch self {
        case .sun:
            return "星期日"
        case .mon:
            return "星期一"
        case .tue:
            return "星期二"
        case .wed:
            return "星期三"
        case .thu:
            return "星期四"
        case .fri:
            return "星期五"
        case .sat:
            return "星期六"
        }
    }
    
    var detail: String {
        switch self {
        case .sun:
            return "週日"
        case .mon:
            return "週一"
        case .tue:
            return "週二"
        case .wed:
            return "週三"
        case .thu:
            return "週四"
        case .fri:
            return "週五"
        case .sat:
            return "週六"
        }
    }
}
