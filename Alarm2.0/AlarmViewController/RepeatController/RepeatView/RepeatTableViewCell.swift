//
//  RepeatTableViewCell.swift
//  Alarm2.0
//
//  Created by 羅承志 on 2022/3/1.
//

import UIKit
import SnapKit

class RepeatTableViewCell: UITableViewCell {
    
    static let identifier = "repeatTableViewCell"
    
    // MARK: - UI
    let weekTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()

    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupUI
    func setupUI() {
        self.addSubview(weekTitleLabel)
        
        weekTitleLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(self)
            make.leading.equalTo(self).offset(10)
        }
    }
}
