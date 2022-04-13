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
    private let alarmLabelView = AlarmLabelView()
    weak var delegate: LabelToAdd?
    var alarmLabel: String = ""
    
    //MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = alarmLabelView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setNavigationBackButton()
        alarmLabelView.alarmLabelTextField.text = alarmLabel
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let text = alarmLabelView.alarmLabelTextField.text {
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
    
    //MARK: SetNavigationBackButton
    private func setNavigationBackButton() {
        title = "標籤"
        self.navigationController?.navigationBar.tintColor = .orange
    }
}
