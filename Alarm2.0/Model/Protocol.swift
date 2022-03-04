//
//  Protocol.swift
//  Alarm2.0
//
//  Created by 羅承志 on 2022/3/1.
//

import Foundation

// MARK: - Protocol
protocol RepeatToAdd: AnyObject {
    func repeatToAdd(repeatSet: Set<Day>)
}

protocol LabelToAdd: AnyObject {
    func labelToAdd(labelSet: String)
}

protocol AlarmSetDelegate: AnyObject {
    func saveAlarm(alarm: Alarm)
    func valueChange(alarm: Alarm, index: Int)
    func deleteAlarm(index: Int)
}
