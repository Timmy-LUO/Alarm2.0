//
//  AddAlarmView.swift
//  Alarm2.0
//
//  Created by 羅承志 on 2022/3/25.
//

import UIKit
import SnapKit

class AddAlarmView: UIView {
    // MARK: - UI
    let addAlarmTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.sectionIndexBackgroundColor = .systemGray2
        tableView.register(DatePickerTableViewCell.self, forCellReuseIdentifier: DatePickerTableViewCell.identifier)
        tableView.register(AddAlarmTableViewCell.self, forCellReuseIdentifier: AddAlarmTableViewCell.identifier)
        tableView.register(AddAlarmSwitchTableViewCell.self, forCellReuseIdentifier: AddAlarmSwitchTableViewCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .singleLine
        tableView.isScrollEnabled = false
        return tableView
    }()

    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - SetupUI
    private func setupUI() {
        addSubview(addAlarmTableView)
        addAlarmTableView.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.leading.equalTo(10)
            make.trailing.equalTo(-10)
        }
    }
}
