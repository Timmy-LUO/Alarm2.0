//
//  AlarmLabelViewController.swift
//  Alarm2.0
//
//  Created by 羅承志 on 2022/2/25.
//

import UIKit
import SnapKit

class AlarmLabelViewController: UIViewController {
    //MARK: - Properites
    weak var delegate: LabelToAdd?
    var alarmLabel: String = ""
    
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
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupViews()
        setNavigationBackButton()
        alarmLabelTextField.text = alarmLabel
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let text = alarmLabelTextField.text {
            if text == "" {
                delegate?.labelToAdd(labelSet: "鬧鐘")
            } else {
                delegate?.labelToAdd(labelSet: text)
            }
        }
    }
    
    //MARK: reture鍵 返回
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        navigationController?.popViewController(animated: true)
        return true
    }
    
    
    //MARK: SetupViews
    func setNavigationBackButton() {
        title = "標籤"
        self.navigationController?.navigationBar.tintColor = .orange
    }
    
    //MARK: - SetupViews
    func setupViews() {
        
        view.addSubview(alarmLabelTextField)
        alarmLabelTextField.snp.makeConstraints { make in
            make.top.equalTo(self.view).offset(300)
            make.centerX.equalTo(self.view)
            make.leading.equalTo(10)
            make.trailing.equalTo(-10)
            make.height.equalTo(50)
        }
    }
}
