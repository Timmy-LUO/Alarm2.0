//
//  AddAlarmSwitchTableViewCell.swift
//  Alarm2.0
//
//  Created by 羅承志 on 2022/3/1.
//

import UIKit
import SnapKit

class AddAlarmSwitchTableViewCell: UITableViewCell {
    
    static let identifier = "addAlarmSwitchTableViewCell"
    
    // MARK: - UI
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    let remindLaterSwitch: UISwitch = {
        let laterSwitch = UISwitch()
        laterSwitch.isOn = true
        return laterSwitch
    }()
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        self.accessoryView = remindLaterSwitch
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - SetupUI
    func setupUI() {
        let view = UIView()
        contentView.addSubview(view)
        view.snp.makeConstraints {make in
            make.edges.equalToSuperview()
            make.height.equalTo(50)
        }
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(self)
            make.leading.equalTo(self).offset(10)
        }
        
        self.addSubview(remindLaterSwitch)
        remindLaterSwitch.snp.makeConstraints { make in
            make.top.equalTo(5)
            make.trailing.equalTo(-1)
        }
    }
}
