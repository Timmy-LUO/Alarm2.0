//
//  AlarmMainViewController.swift
//  Alarm2.0
//
//  Created by 羅承志 on 2022/2/25.
//

import UIKit
import SnapKit

class AlarmMainViewController: UIViewController {
    // MARK: - Properites
    private let alarmMainView = AlarmMainView()
    var database = AlarmDatabase()
    var tempAlarm = Alarm()
    let addAlarmViewController = AddAlarmViewController()
    weak var alarmSetDelegate: AlarmSetDelegate?

    
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = alarmMainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "鬧鐘"
        setupTableViewDelegate()
        setNavigationItem()
        database.valueChanged = { [weak self] _ in
//            print("reload")
            self?.alarmMainView.alarmMainTableView.reloadData()
        }
    }
    
    //MARK: - SetupTableViewDelegate
    private func setupTableViewDelegate() {
        alarmMainView.alarmMainTableView.dataSource = self
        alarmMainView.alarmMainTableView.delegate = self
    }
    
    //MARK: - SetEditing
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        alarmMainView.alarmMainTableView.setEditing(editing, animated: true)
        if alarmMainView.alarmMainTableView.isEditing {
            self.navigationItem.leftBarButtonItem?.title = "完成"
            alarmMainView.alarmMainTableView.allowsSelectionDuringEditing = true
        } else {
            self.navigationItem.leftBarButtonItem?.title = "編輯"
            alarmMainView.alarmMainTableView.allowsSelectionDuringEditing = false
        }
    }
    
    //MARK: - SetNavigationItem
    private func setNavigationItem() {
        //leftButton
        self.navigationItem.leftBarButtonItem = editButtonItem
        editButtonItem.tintColor = .orange
        editButtonItem.title = "編輯"
        
        //rightButton
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addButton))
        addButton.tintColor = .orange
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    //MARK: - AddButton
    @objc
    func addButton() {
        let vc = AddAlarmViewController()
        vc.alarmSetDelegate = self
        let navigationController = UINavigationController(rootViewController: vc)
        present(navigationController, animated: true, completion: nil)
        setEditing(false, animated: false)
    }
    
    
}

//MARK: - TableViewDataSource
extension AlarmMainViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return database.numberOfAlarms
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlarmMainTableViewCell.identifier, for: indexPath) as? AlarmMainTableViewCell else { return UITableViewCell() }
        let alarm = database.getAlarm(at: indexPath.row)
        cell.update(alarm: alarm)
        
        return cell
    }
}

//MARK: - TableViewDelegate
extension AlarmMainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AddAlarmViewController()
        let navigationController = UINavigationController(rootViewController: vc)
        vc.alarmSetDelegate = self
        vc.alarm = database.alarms[indexPath.row]
        vc.cellIndexPath = indexPath.row
        present(navigationController, animated: true, completion: nil)
        setEditing(false, animated: false)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            database.deleteAlarm(at: indexPath.row)
        default:
            break
        }
    }
}


//MARK: - add, edit, delete, sort
extension AlarmMainViewController: AlarmSetDelegate {
    
    func saveAlarm(alarm: Alarm) {
        database.addAlarm(alarm)
    }
    
    func valueChange(alarm: Alarm, index: Int) {
        database.replacingAlarm(alarm, at: index)
    }
    
    func deleteAlarm(index: Int) {
        database.deleteAlarm(at: index)
    }
}
