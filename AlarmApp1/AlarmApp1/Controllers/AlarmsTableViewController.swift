//
//  AlarmTableViewController.swift
//  AlarmApp1
//
//  Created by Leah Cluff on 5/6/19.
//  Copyright © 2019 Leah Cluff. All rights reserved.
//

import UIKit

protocol AlarmTableViewCellDelegate: class {
    func alarmWasToggled(sender: AlarmTableViewCell)
}

class AlarmsTableViewController: UITableViewController, AlarmTableViewCellDelegate, AlarmScheduler {
    
    let alarmCellID = "alarmCellID"
    
    func alarmWasToggled(sender: AlarmTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else {return}
        let alarm = AlarmController.shared.alarms[indexPath.row]
        AlarmController.shared.toggleEnabled(for: alarm)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated:Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return AlarmController.shared.alarms.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: alarmCellID, for: indexPath) as? AlarmTableViewCell
        let alarm = AlarmController.shared.alarms[indexPath.row]
        cell?.delegate = self
        cell?.alarm = alarm
        
        return cell ?? UITableViewCell()
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alarm = AlarmController.shared.alarms[indexPath.row]
            AlarmController.shared.delete(alarm: alarm)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueID = segue.identifier,
            let segueOptions = AlarmSegueOptions(rawValue: segueID) else { return }
       
        switch segueOptions {
        case .pushNewAlarm:()
        case .toAlarmVC:
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let alarm = AlarmController.shared.alarms[indexPath.row]
            let destinationVC = segue.destination as? AlarmDetailTableViewController
            destinationVC?.alarm = alarm
        }
    }
}

enum AlarmSegueOptions: String, CaseIterable {
    case pushNewAlarm
    case toAlarmVC
}
