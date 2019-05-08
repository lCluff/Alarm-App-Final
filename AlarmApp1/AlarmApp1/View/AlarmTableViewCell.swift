//
//  AlarmTableViewCell.swift
//  AlarmApp1
//
//  Created by Leah Cluff on 5/6/19.
//  Copyright © 2019 Leah Cluff. All rights reserved.
//

import UIKit

class AlarmTableViewCell: UITableViewCell {
    
    var alarm: Alarm?{
        didSet{
            updateViews()
        }
    }
    
    weak var delegate: AlarmTableViewCellDelegate?
    
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func updateViews(){
        guard let alarm = alarm else {return}
        timeLabel.text = alarm.fireTimeAsString
        nameLabel.text = alarm.name
        alarmSwitch.isOn = alarm.enabled
        
    }
    
    @IBAction func alarmSwitched(_ sender: Any) {
        delegate?.alarmWasToggled(sender: self)
        
    }
}

