//
//  AlarmDetailTableViewController.swift
//  AlarmApp1
//
//  Created by Leah Cluff on 5/6/19.
//  Copyright © 2019 Leah Cluff. All rights reserved.
//

import UIKit


class AlarmDetailTableViewController: UITableViewController, AlarmScheduler {
    
    var alarm: Alarm?{
        didSet{
            loadViewIfNeeded()
            self.updateViews()
        }
    }
    var alarmIsOn: Bool = true
    
    @IBOutlet private weak var datePicker: UIDatePicker!
    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var alarmEnabledButton: UIButton!
    
    @IBAction private func alarmEnabledButtonTouched(_ sender: Any) {
        if let alarm = alarm {
            AlarmController.shared.toggleEnabled(for: alarm)
            alarmIsOn = alarm.enabled
        } else {
            alarmIsOn = !alarmIsOn
        }
        setUpAlarmButton()
    }
    
    @IBAction private func saveButtonTapped(_ sender: Any) {
        defer { self.navigationController?.popViewController(animated: true) }
        
        guard let title = titleTextField.text,
            !title.isEmpty,
            let alarm = alarm else {
                
                AlarmController.shared.create(name: titleTextField.text ?? "", fireDate: datePicker.date, enabled: alarmIsOn)
                return
        }
        
        AlarmController.shared.update(alarm: alarm, name: title, fireDate: datePicker.date, enabled: alarmIsOn)
    }
}

fileprivate extension AlarmDetailTableViewController {
    func updateViews(){
        guard let alarm = alarm else {return}
        alarmIsOn = alarm.enabled
        datePicker.date = alarm.fireDate
        titleTextField.text = alarm.name
        setUpAlarmButton()
    }
    
    func setUpAlarmButton(){
        switch alarmIsOn {
        case true:
            alarmEnabledButton.backgroundColor = UIColor.cyan
            alarmEnabledButton.setTitle("ON", for: .normal)
        case false:
            alarmEnabledButton.backgroundColor = UIColor.gray
            alarmEnabledButton.setTitle("OFF", for: .normal)
        }
    }
}
