//
//  AlarmMainView.swift
//  Alarm2.0
//
//  Created by 羅承志 on 2022/3/25.
//

import UIKit

class AlarmMainView: UIView {
    // MARK: - UIs
    let alarmMainTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(AlarmMainTableViewCell.self, forCellReuseIdentifier: AlarmMainTableViewCell.identifier)
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
    func setupUI() {
        addSubview(alarmMainTableView)
        alarmMainTableView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
}
