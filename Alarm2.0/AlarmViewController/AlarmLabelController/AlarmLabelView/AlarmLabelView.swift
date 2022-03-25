//
//  AlarmLabelView.swift
//  Alarm2.0
//
//  Created by 羅承志 on 2022/3/25.
//

import UIKit
import SnapKit

class AlarmLabelView: UIView {
    //MARK: - UI
    let alarmLabelTextField: UITextField = {
        let textField = UITextField()
        textField.returnKeyType = .done
        textField.textColor = .white
        textField.backgroundColor = .systemGray3
        textField.clearButtonMode = .whileEditing
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 20)
        textField.becomeFirstResponder()
        //textField.enablesReturnKeyAutomatically = true
        return textField
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
        addSubview(alarmLabelTextField)
        alarmLabelTextField.snp.makeConstraints { make in
            make.top.equalTo(self).offset(300)
            make.centerX.equalTo(self)
            make.leading.equalTo(10)
            make.trailing.equalTo(-10)
            make.height.equalTo(50)
        }
    }
}
