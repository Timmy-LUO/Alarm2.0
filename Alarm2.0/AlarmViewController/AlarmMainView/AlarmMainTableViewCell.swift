//
//  AlarmMainTableViewCell.swift
//  Alarm2.0
//
//  Created by 羅承志 on 2022/3/1.
//

import UIKit
import SnapKit

class AlarmMainTableViewCell: UITableViewCell {
    //MARK: - Properties
    static let identifier = "alarmOtherTableViewCell"
    var switchToggle: ((Bool) -> Void)?
    
    
    // MARK: - UI
    var amPmLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 35)
        return label
    }()
    
    var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 50)
        label.textColor = .lightGray
        return label
    }()
    
    var detailLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    let dateSwitch: UISwitch = {
        let dateSwitch = UISwitch()
        dateSwitch.isOn = true
        dateSwitch.addTarget(self, action: #selector(dateSwitchTarget), for: .valueChanged)
        return dateSwitch
    }()
    
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupViews
    func setupViews() {
        contentView.addSubview(amPmLabel)
        amPmLabel.snp.makeConstraints { make in
            make.top.equalTo(-45)
            make.leading.equalTo(13)
            make.bottom.equalTo(10)
        }
        
        contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(-45)
            make.leading.equalTo(amPmLabel.snp.trailing).inset(-5)
            make.bottom.equalTo(10)
        }
        
        contentView.addSubview(detailLabel)
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(amPmLabel.snp.bottom).inset(50)
            make.leading.equalTo(13)
        }
    }
    
    //MARK: - update
    func update(alarm: Alarm) {
        amPmLabel.text = alarm.appearAmPm()
        timeLabel.text = alarm.appearTime()
        detailLabel.text = alarm.label + alarm.alarmAppearString
        accessoryView = dateSwitch
        dateSwitch.isOn = alarm.isOn
        editingAccessoryType = .disclosureIndicator
    }
    
    @objc
    func dateSwitchTarget(_ sender: UISwitch) {
        switchToggle?(sender.isOn)
    }
}
