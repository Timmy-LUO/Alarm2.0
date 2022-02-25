//
//  MainTabbarViewController.swift
//  Alarm2.0
//
//  Created by 羅承志 on 2022/2/25.
//

import UIKit

class MainTabbarViewController: UITabBarController {
    
    let worldClockVC = WorldClockViewController()
    let alarmVC = AlarmMainViewController()
    let stopWatchVC = StopWatchViewController()
    let timerVC = TimerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        worldClockVC.tabBarItem.image = UIImage(systemName: "network")
        alarmVC.tabBarItem.image = UIImage(systemName: "alarm.fill")
        stopWatchVC.tabBarItem.image = UIImage(systemName: "stopwatch.fill")
        timerVC.tabBarItem.image = UIImage(systemName: "timer")
        
        worldClockVC.title = "世界鬧鐘"
        alarmVC.title = "鬧鐘"
        stopWatchVC.title = "碼表"
        timerVC.title = "計時器"
        
        let navigationAlarm = UINavigationController(rootViewController: alarmVC)
        
        setViewControllers([worldClockVC, navigationAlarm, stopWatchVC, timerVC], animated: false)
        
        // NaviBar不透明
        navigationAlarm.navigationBar.isTranslucent = false
        // NaviBar背景色
        navigationAlarm.navigationBar.barTintColor = .black
        // NaviBar文字顏色
        navigationAlarm.navigationBar.titleTextAttributes =  [.foregroundColor: UIColor.white]
        
        // Tabbar背景色
        self.tabBar.barTintColor = .clear
        // Tabbar文字顏色
        self.tabBar.tintColor = .orange
    }
}
