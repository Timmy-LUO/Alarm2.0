//
//  AddAlarmViewController.swift
//  Alarm2.0
//
//  Created by 羅承志 on 2022/2/25.
//

import UIKit
import SnapKit

class AddAlarmViewController: UIViewController {
    
    // MARK: - Properites
    var addAlarmCell: [AddCellTitle] = [.rep, .tag, .sound, .snooze]
    
    var alarm: Alarm!
    var selection: ModelSelection?
    
    weak var alarmSetDelegate: AlarmSetDelegate?
    var cellIndexPath: Int?
    
    
    // MARK: - UI
    let addAlarmTableView: UITableView = {
        let tableView = UITableView()
        tableView .register(DatePickerHeaderView.self, forHeaderFooterViewReuseIdentifier: DatePickerHeaderView.identifier)
        tableView.register(AddAlarmTableViewCell.self, forCellReuseIdentifier: AddAlarmTableViewCell.identifier)
        tableView.register(AddAlarmSwitchTableViewCell.self, forCellReuseIdentifier: AddAlarmSwitchTableViewCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.sectionHeaderHeight = 200
        tableView.separatorStyle = .singleLine
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        checkAlarm()
        view.backgroundColor = .black
        addAlarmTableView.dataSource = self
        addAlarmTableView.delegate = self
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
    @objc func saveButton() {
        if title == "加入鬧鐘" {
            alarmSetDelegate?.saveAlarm(alarm: alarm)
        } else {
            alarmSetDelegate?.valueChange(alarm: alarm, index: cellIndexPath!)
        }
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - CancelButton
    @objc func cancelButton() {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - SetViews
    func setViews() {
        view.addSubview(addAlarmTableView)
        
        addAlarmTableView.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.leading.equalTo(0)
            make.trailing.equalTo(-0)
        }
    }
}

//MARK: - UITableViewDataSource
extension AddAlarmViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if title == "加入鬧鐘" {
            return 1
        } else {
            return 2
        }
//        switch alarm.modeSelection {
//        case .add:
//            return 1
//        case .edit:
//            return 2
//        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addAlarmCell.count
        
//        switch alarm.modeSelection {
//        case .edit:
//            switch section {
//            case 0:
//                print("c0 3")
//                return 2
//            case 1:
//                print("c1 4")
//                return 2
//            default:
//                print("d 1")
//                return 2
//            }
//        case .add:
//            switch section {
//            case 0:
//                print("c 4")
//                return 4
//            default:
//                print("d 4")
//                return 4
//            }
//        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = addAlarmCell[indexPath.row]
        switch cellType {
        case .snooze:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddAlarmSwitchTableViewCell.identifier, for: indexPath) as? AddAlarmSwitchTableViewCell else { return UITableViewCell() }
            cell.titleLabel.text = addAlarmCell[indexPath.row].text
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddAlarmTableViewCell.identifier, for: indexPath) as? AddAlarmTableViewCell else { return UITableViewCell() }
            if indexPath.section == 0 {
                cell.titleLabel.text = addAlarmCell[indexPath.row].text
                if indexPath.row == 0 {
                    cell.contentLabel.text = alarm.repeatString
                }
                if indexPath.row == 1 {
                    cell.contentLabel.text = alarm.label
                }
                if indexPath.row == 2 {
                    cell.contentLabel.text = "經典"
                }
                return cell
            }
            return cell
        }
        
        
        
        
        
       
    }
}

//MARK: - UITableViewDelegate
extension AddAlarmViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: DatePickerHeaderView.identifier) as! DatePickerHeaderView
        header.dateChanged = { [weak self] date in
            self?.alarm.date = date
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
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

