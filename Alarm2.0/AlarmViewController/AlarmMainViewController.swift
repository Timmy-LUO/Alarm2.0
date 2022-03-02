//
//  AlarmMainViewController.swift
//  Alarm2.0
//
//  Created by 羅承志 on 2022/2/25.
//

import UIKit

class AlarmMainViewController: UIViewController {
    
    // MARK: - Properites
    var tempAlarm = Alarm()
    let addAlarmViewController = AddAlarmViewController()
    weak var AlarmSetDelegate: AlarmSetDelegate?
    
    // MARK: - UI
    let AlarmMainTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(AlarmMainTableViewCell.self, forCellReuseIdentifier: AlarmMainTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "鬧鐘"
        AlarmMainTableView.dataSource = self
        AlarmMainTableView.delegate = self
        setNavigationItem()
        
    }
    
    //MARK: - SetEditing
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        AlarmMainTableView.setEditing(editing, animated: true)
        if AlarmMainTableView.isEditing {
            self.navigationItem.leftBarButtonItem?.title = "完成"
            AlarmMainTableView.allowsSelectionDuringEditing = true
        } else {
            self.navigationItem.leftBarButtonItem?.title = "編輯"
            AlarmMainTableView.allowsSelectionDuringEditing = false
        }
    }
    
    //MARK: - SetNavigationItem
    func setNavigationItem() {
        //leftButton
        self.navigationItem.leftBarButtonItem = editButtonItem
        editButtonItem.tintColor = .orange
        editButtonItem.title = "編輯"
        
        //rightButton
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addButton))
        addButton.tintColor = .orange
        self.navigationItem.rightBarButtonItem = addButton
    }
    //MARK: AddButton
    @objc func addButton() {
        
        let navigationController = UINavigationController(rootViewController: addAlarmViewController)
        present(navigationController, animated: true, completion: nil)
    }
    
    
    
}

extension AlarmMainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlarmMainTableViewCell.identifier, for: indexPath) as? AlarmMainTableViewCell else { return UITableViewCell() }
        //let alarmIndex = tempAlarm.alarms[indexPath.row]
        cell.timeLabel.text = tempAlarm.appearTime()
        cell.amPmLabel.text = tempAlarm.appearAmPm()
        cell.detailLabel.text = tempAlarm.alarms[indexPath.row].label + tempAlarm.alarms[indexPath.row].repeatString
        let isOnSwitch = UISwitch(frame: .zero)
        isOnSwitch.isOn = tempAlarm.alarms[indexPath.row].isOn
        cell.accessoryView = isOnSwitch
        cell.editingAccessoryType = .disclosureIndicator
        AlarmMainTableView.rowHeight = 100
        cell.selectionStyle = .none
        
        return cell
    }
}

extension AlarmMainViewController: UITableViewDelegate {
    
}

//MARK: - add, edit, delete
extension AlarmMainViewController: AlarmSetDelegate {
    func saveAlarm(alarm: Alarm) {
        tempAlarm.alarms.append(alarm)
    }
    
    func valueChange(alarm: Alarm, index: Int) {
        tempAlarm.alarms[index] = alarm
    }
    
    func deleteAlarm(index: Int) {
        tempAlarm.alarms.remove(at: index)
    }
    
    func alarmSort() {
        
    }
    
    
}
