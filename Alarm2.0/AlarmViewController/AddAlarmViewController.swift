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
    var tempAlarm = Alarm()
    
    // MARK: - UI
    let addAlarmTableView: UITableView = {
        let tableView = UITableView()
        tableView .register(DatePickerHeaderView.self, forHeaderFooterViewReuseIdentifier: DatePickerHeaderView.identifier)
        tableView.register(AddAlarmTableViewCell.self, forCellReuseIdentifier: AddAlarmTableViewCell.identifier)
        tableView.register(AddAlarmSwitchTableViewCell.self, forCellReuseIdentifier: AddAlarmSwitchTableViewCell.identifier)
        tableView.sectionHeaderHeight = 200
        tableView.separatorStyle = .singleLine
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let tableViewHeader: UITableViewHeaderFooterView = {
        let header = UITableViewHeaderFooterView()
        return header
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        addAlarmTableView.dataSource = self
        addAlarmTableView.delegate = self
        setupNavigationBarButtonItem()
        setViews()
        
    }
    
    
    //MARK: - SetNaviBarItem
    func setupNavigationBarButtonItem() {
        //title
        title = tempAlarm.modeSelection.title
        
        //Left Button
        let cancelButton = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(cancelButton))
        cancelButton.tintColor = .orange
        self.navigationItem.leftBarButtonItem = cancelButton
        
        //Right Button
        let button = UIBarButtonItem(title: "儲存", style: .plain, target: self, action: #selector(saveButton))
        button.tintColor = .orange
        self.navigationItem.rightBarButtonItem = button
    }
    
    @objc func saveButton() {
        
    }
    
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
    func numberOfSections(_ tableView: UITableView) -> Int {
        switch tempAlarm.modeSelection {
        case .add:
            return 1
        case .edit:
            return 2
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addAlarmCell.count
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
                    cell.contentLabel.text = tempAlarm.repeatString
                }
                if indexPath.row == 1 {
                    cell.contentLabel.text = tempAlarm.label
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
            repeatVC.isSelectedDay = tempAlarm.selectDay
            self.navigationController?.pushViewController(repeatVC, animated: true)
        case .tag:
            let alarmLabelVC = AlarmLabelViewController()
            alarmLabelVC.delegate = self
            alarmLabelVC.alarmLabel = tempAlarm.label
            self.navigationController?.pushViewController(alarmLabelVC, animated: true)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: DatePickerHeaderView.identifier)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
}

//MARK: - RepeatToAdd
extension AddAlarmViewController: RepeatToAdd {
    func repeatToAdd(repeatSet: Set<Day>) {
        tempAlarm.selectDay = repeatSet
        addAlarmTableView.reloadData()
    }
}

//MARK: - LabelToAdd
extension AddAlarmViewController: LabelToAdd {
    func labelToAdd(labelSet: String) {
        tempAlarm.label = labelSet
        addAlarmTableView.reloadData()
    }
}
