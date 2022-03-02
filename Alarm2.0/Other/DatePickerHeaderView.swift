//
//  DatePickerHeaderView.swift
//  Alarm2.0
//
//  Created by 羅承志 on 2022/2/25.
//

import UIKit
import SnapKit

class DatePickerHeaderView: UITableViewHeaderFooterView {
    
    static let identifier = "datePickerHeaderView"
    
    var dateChanged: ( (Date) -> Void)?
    
    //MARK: - UI
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        // DatePicker顯示時間
        datePicker.datePickerMode = .time
        // DatePicker顯示24小時制
        datePicker.locale = Locale(identifier: "zh_Hant_TW")
        datePicker.preferredDatePickerStyle = .wheels
//        datePicker.setValue(UIColor.white, forKey: "text")
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    //MARK: - Init
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - SetViews
    func setViews() {
        contentView.addSubview(datePicker)
        
        datePicker.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        datePicker.addTarget(self, action: #selector(datePickerChanged(_:)), for: .valueChanged)
    }
    
    @objc func datePickerChanged(_ datePicker: UIDatePicker) {
//        print(datePicker.date)
        dateChanged?(datePicker.date)
    }
}
