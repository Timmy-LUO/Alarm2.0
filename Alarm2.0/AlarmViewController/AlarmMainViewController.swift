//
//  AlarmMainViewController.swift
//  Alarm2.0
//
//  Created by 羅承志 on 2022/2/25.
//

import UIKit

class AlarmMainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "鬧鐘"
        setNavigationItem()
        
    }
    
    func setNavigationItem() {
        //leftButton
        self.navigationItem.leftBarButtonItem = editButtonItem
        editButtonItem.tintColor = .orange
        editButtonItem.title = "編輯"
        //rightButton
        
    }
    
    
}
