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
    weak var delegate: RepeatToAdd?
    var days: [Day] = Day.allCases
    var isSelectedDay = Set<Day>()
    
    //MARK: - UI
    let repeatWeekTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray5
        tableView.register(RepeatTableViewCell.self, forCellReuseIdentifier: RepeatTableViewCell.identifier)
        tableView.separatorStyle = .singleLine
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        repeatWeekTableView.dataSource = self
        repeatWeekTableView.delegate = self
        setupViews()
        setupNaviItem()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.repeatToAdd(repeatSet: isSelectedDay)
    }
    
    
    //MARK: - SetupViews
    func setupViews() {
        view.addSubview(repeatWeekTableView)
        
        repeatWeekTableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(50)
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view)
            make.height.equalTo(350)
        }
    }
    
    func setupNaviItem() {
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepeatTableViewCell.identifier, for: indexPath) as? RepeatTableViewCell else { return UITableViewCell() }
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
        repeatWeekTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
