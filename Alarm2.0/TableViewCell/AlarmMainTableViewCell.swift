//
//  AlarmMainTableViewCell.swift
//  Alarm2.0
//
//  Created by 羅承志 on 2022/3/1.
//

import UIKit

class AlarmMainTableViewCell: UITableViewCell {

    static let identifier = "alarmOtherTableViewCell"
    
    // MARK: - UI
    var amPmLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 35)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 50)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var detailLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        contentView.addSubview(timeLabel)
        contentView.addSubview(detailLabel)
        
        amPmLabel.snp.makeConstraints { make in
            make.top.equalTo(-20)
            make.leading.equalTo(13)
            make.bottom.equalTo(10)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(-25)
            make.leading.equalTo(amPmLabel.snp.trailing).inset(-5)
            make.bottom.equalTo(10)
        }
        
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(amPmLabel.snp.bottom).inset(40)
            make.leading.equalTo(13)
            make.bottom.equalTo(10)
        }
    }
    
    func update(alarm: Alarm) {
        amPmLabel.text = alarm.appearAmPm()
        timeLabel.text = alarm.appearTime()
        detailLabel.text = alarm.label + alarm.alarmAppearString
        
        let isOnSwitch = UISwitch(frame: .zero)
        isOnSwitch.isOn = alarm.isOn
        accessoryView = isOnSwitch
        editingAccessoryType = .disclosureIndicator
        //AlarmMainTableView.rowHeight = 100
        selectionStyle = .none
    }
}
