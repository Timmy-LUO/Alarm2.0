//
//  AddAlarmViewController.swift
//  Alarm2.0
//
//  Created by 羅承志 on 2022/2/25.
//

import UIKit
import SnapKit

final class AddAlarmViewController: UIViewController {
    
    // MARK: - Properites
    var addAlarmCell: [AddCellTitle] = [.rep, .tag, .sound, .snooze]
    var alarm: Alarm!
//    var selection: ModelSelection?
    
    weak var alarmSetDelegate: AlarmSetDelegate?
    var cellIndexPath: Int?
    
    
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
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        addAlarmTableView.dataSource = self
        addAlarmTableView.delegate = self
        checkAlarm()
        setupNavigationBarButtonItem()
        setViews()
    }
    
    //MARK: - CheckAlarmTitle
    private func checkAlarm() {
        if alarm == nil {
            // add
            alarm = Alarm()
            title = "加入鬧鐘"
        } else {
            // edit
            title = "編輯鬧鐘"
        }
    }
    
    //MARK: - SetNaviBarItem
    func setupNavigationBarButtonItem() {
        //Left Button
        let cancelButton = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(cancelButton))
        cancelButton.tintColor = .orange
        self.navigationItem.leftBarButtonItem = cancelButton
        
        //Right Button
        let button = UIBarButtonItem(title: "儲存", style: .plain, target: self, action: #selector(saveButton))
        button.tintColor = .orange
        self.navigationItem.rightBarButtonItem = button
    }
    
    //MARK: - SaveButton
    @objc
    func saveButton() {

        if title == "加入鬧鐘" {
//            alarm.localNotification()
//            print("add \(alarm.date)")
            alarmSetDelegate?.saveAlarm(alarm: alarm)
        } else {
//            alarm.localNotification()
//            print("edit \(alarm.date)")
            alarmSetDelegate?.valueChange(alarm: alarm, index: cellIndexPath!)
        }
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - CancelButton
    @objc
    func cancelButton() {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - SetViews
    func setViews() {
        
        view.addSubview(addAlarmTableView)
        addAlarmTableView.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.leading.equalTo(10)
            make.trailing.equalTo(-10)
        }
    }
}

//MARK: - UITableViewDataSource
extension AddAlarmViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if title == "加入鬧鐘" {
            return 2
        } else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 4
        } else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: DatePickerTableViewCell.identifier, for: indexPath) as! DatePickerTableViewCell
            cell.backgroundColor = .black
            cell.dateChanged = { date in
                self.alarm.date = date
            }
            
            return cell
        } else if indexPath.section == 1 {
            if indexPath.row == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: AddAlarmSwitchTableViewCell.identifier, for: indexPath) as! AddAlarmSwitchTableViewCell
                cell.titleLabel.text = "稍後提醒"
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: AddAlarmTableViewCell.identifier, for: indexPath) as! AddAlarmTableViewCell
                if indexPath.row == 0 {
                    cell.titleLabel.text = "重複"
                    cell.contentLabel.text = alarm.repeatString
                } else if indexPath.row == 1 {
                    cell.titleLabel.text = "標籤"
                    cell.contentLabel.text = alarm.label
                } else {
                    cell.titleLabel.text = "提示聲"
                    cell.contentLabel.text = "經典"
                }
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = "刪除鬧鐘"
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = .red
            return cell
        }
    }
}

//MARK: - UITableViewDelegate
extension AddAlarmViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let cellType = addAlarmCell[indexPath.row]
            switch cellType {
            case .rep:
                let repeatVC = RepeatViewController()
                repeatVC.delegate = self
                repeatVC.isSelectedDay = alarm.selectDay
                self.navigationController?.pushViewController(repeatVC, animated: true)
            case .tag:
                let alarmLabelVC = AlarmLabelViewController()
                alarmLabelVC.delegate = self
                alarmLabelVC.alarmLabel = alarm.label
                self.navigationController?.pushViewController(alarmLabelVC, animated: true)
            default:
                break
            }
        } else if indexPath.section == 2 {
            alarmSetDelegate?.deleteAlarm(index: cellIndexPath!)
            dismiss(animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 2 {
            return " "
        }
        return " "
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 2 {
            return 30
        }
        return 0
    }
}

//MARK: - RepeatToAdd
extension AddAlarmViewController: RepeatToAdd {
    func repeatToAdd(repeatSet: Set<Day>) {
        alarm.selectDay = repeatSet
        addAlarmTableView.reloadData()
    }
}

//MARK: - LabelToAdd
extension AddAlarmViewController: LabelToAdd {
    func labelToAdd(labelSet: String) {
        alarm.label = labelSet
        addAlarmTableView.reloadData()
    }
}

