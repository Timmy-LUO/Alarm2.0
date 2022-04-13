//
//  RepeatView.swift
//  Alarm2.0
//
//  Created by 羅承志 on 2022/3/25.
//

import UIKit
import SnapKit

class RepeatView: UIView {
    //MARK: - UI
    let repeatWeekTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray5
        tableView.register(RepeatTableViewCell.self, forCellReuseIdentifier: RepeatTableViewCell.identifier)
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
        addSubview(repeatWeekTableView)
        repeatWeekTableView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(50)
            make.centerX.equalTo(self)
            make.width.equalTo(self)
            make.height.equalTo(350)
        }
    }
}
