//
//  RepeatViewController.swift
//  Alarm2.0
//
//  Created by 羅承志 on 2022/2/25.
//

import UIKit
import SnapKit

class RepeatViewController: UIViewController {
    //MARK: - properites
    private let repeatView = RepeatView()
    weak var delegate: RepeatToAdd?
    var days: [Day] = Day.allCases
    var isSelectedDay = Set<Day>()
    
    //MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = repeatView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupTableViewDelegate()
        setupNaviItem()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.repeatToAdd(repeatSet: isSelectedDay)
    }
    
    private func setupTableViewDelegate() {
        repeatView.repeatWeekTableView.dataSource = self
        repeatView.repeatWeekTableView.delegate = self
    }
    
    private func setupNaviItem() {
        navigationItem.title = "重複"
        self.navigationController?.navigationBar.tintColor = .orange
    }
}

 // MARK: - UITableViewDataSource
extension RepeatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepeatTableViewCell.identifier, for: indexPath) as! RepeatTableViewCell
        let day = days[indexPath.row]
        cell.textLabel?.text = day.text
        let isSelectorDayContained = isSelectedDay.contains(day)
        cell.accessoryType = isSelectorDayContained ? .checkmark : .none
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension RepeatViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let day = days[indexPath.row]
        let isSelectorDayContained = isSelectedDay.contains(day)
        if isSelectorDayContained {
            isSelectedDay.remove(day)
        } else {
            isSelectedDay.insert(day)
        }
        repeatView.repeatWeekTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
