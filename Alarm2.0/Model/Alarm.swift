//
//  Alarm.swift
//  Alarm2.0
//
//  Created by 羅承志 on 2022/2/25.
//

import Foundation
import UserNotifications

// 管理鬧鐘
// MARK: - AlarmDatabase
class AlarmDatabase {
    
    var valueChanged: (([Alarm]) -> Void)?
    
    // singleton
    private let userDefaultKey = "AlarmDatabase"
    private let userDefault = UserDefaults.standard
    private let userNotification = UserNotification()
    
    private(set) var alarms: [Alarm] = [] {
        didSet {
            saveAlarms()
            valueChanged?(alarms)
        }
    }
    
    init() {
        load()
    }
    
    var numberOfAlarms: Int {
        return alarms.count
    }
    
    func getAlarm(at index: Int) -> Alarm {
        return alarms[index]
    }
   
    func addAlarm(_ alarm: Alarm) {
        alarms.append(alarm)
        alarms.sort(by: { $0.date < $1.date })
    }
    
    func deleteAlarm(at index: Int) {
        alarms.remove(at: index)
        alarms.sort(by: { $0.date < $1.date })
    }
    
    func replacingAlarm(_ alarm: Alarm) {
        guard let index = alarms.firstIndex(where: { $0.id == alarm.id }) else {
            return
        }
        replacingAlarm(alarm, at: index)
    }
    
    func replacingAlarm(_ alarm: Alarm, at index: Int) {
        alarms[index] = alarm
        alarms.sort(by: { $0.date < $1.date })
    }
    
    //MARK: - UserDefaults
    private func saveAlarms() {
        do {
//            print("Save alarms: \(alarms.count)")
            let data = try JSONEncoder().encode(alarms)
            userDefault.set(data, forKey: userDefaultKey)
        } catch {
            print(error)
        }
    }
    
    private func load() {
        guard let data = userDefault.data(forKey: userDefaultKey) else {
            return
        }
        do {
            let decoded = try JSONDecoder().decode([Alarm].self, from: data)
//            print("Load alarm count: \(decoded.count)")
            self.alarms = decoded
        } catch {
            print(error)
        }
    }
}

// MARK: - Alarm
struct Alarm: Codable {
    
    init() {
        self.id = Alarm.getOrderNumber()
        self.date = Date()
        self.label = "鬧鐘"
        self.isOn = true
        self.selectDay = []
//        self.modeSelection = .add
    }
    
    static var orderNumbers = 0
    
    static func getOrderNumber() -> Int {
        orderNumbers += 1
        //print("產生 orderNumber: #\(orderNumbers)")
        return orderNumbers
    }
    
    var id: Int
    var date: Date = Date()
    var label: String = "鬧鐘"
    var isOn: Bool = true {
        didSet {
            if isOn {
                UserNotification.addNotification(alarm: self)
            } else {
                UserNotification.removeNotification(alarmId: id)
            }
        }
    }
    
    
    var selectDay: Set<Day> = []
//    var modeSelection: ModelSelection = .add
    
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
    
    var alarmAppearString: String {
        switch selectDay {
        case [.mon,.tue,.wed,.thu,.fri]:
            return "，平日"
        case [.sat,.sun]:
            return "，週末"
        case [.sun,.mon,.tue,.wed,.thu,.fri,.sat]:
            return "，每天"
        case []:
            return ""
        default :
            if selectDay.count > 1 {
                return "，" + selectDay
                    .sorted(by: { $0.rawValue < $1.rawValue })
                    .map{ $0.detail }
                    .joined(separator: " ")
            }
            return selectDay
                .sorted(by: { $0.rawValue < $1.rawValue })
                .map({ "，每\($0.detail)" })
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
        formatter.locale = .current
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
//enum ModelSelection: String, CaseIterable, Codable {
//    case add, edit
//    
//    var title: String {
//        switch self {
//        case .add:
//            return "加入鬧鐘"
//        case .edit:
//            return "編輯鬧鐘"
//        }
//    }
//}

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

enum Day: Int, CaseIterable, Codable {
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

