//
//  DatePickerTableViewCell.swift
//  Alarm2.0
//
//  Created by 羅承志 on 2022/3/4.
//

import UIKit
import SnapKit

class DatePickerTableViewCell: UITableViewCell {
    
    static let identifier = "DatePickerTableViewCell"
    
    var dateChanged: ((Date) -> Void)?
    
    //MARK: - UI
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        // DatePicker顯示時間
        datePicker.datePickerMode = .time
        // DatePicker顯示24小時制
        datePicker.locale = Locale(identifier: "zh_Hant_TW")
        datePicker.preferredDatePickerStyle = .wheels
//        datePicker.setValue(UIColor.white, forKey: "text")
        return datePicker
    }()
    
    //MARK: - Init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    //MARK: - SetupUI
    private func setupUI() {
        contentView.addSubview(datePicker)
        datePicker.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        datePicker.addTarget(self, action: #selector(datePickerChanged(_:)), for: .valueChanged)
    }
    
    @objc
    private func datePickerChanged(_ datePicker: UIDatePicker) {
//        print(datePicker.date)
        dateChanged?(datePicker.date)
    }
}
