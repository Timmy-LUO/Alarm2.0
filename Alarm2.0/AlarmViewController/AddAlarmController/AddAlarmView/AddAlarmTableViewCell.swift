//
//  AddAlarmTableViewCell.swift
//  Alarm2.0
//
//  Created by 羅承志 on 2022/2/25.
//

import UIKit
import SnapKit

class AddAlarmTableViewCell: UITableViewCell {
    
    static let identifier = "addAlarmTableViewCell"
    
    //MARK: - UI
    let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let detailImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        return imageView
    }()
    
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        self.accessoryView = detailImageView
        self.tintColor = .systemGray4
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
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(self)
            make.leading.equalTo(self).offset(10)
        }
        
        contentView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(self)
            make.trailing.equalTo(self).offset(-50)
        }
    }
}
