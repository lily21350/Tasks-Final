//
//  myTableViewCell.swift
//  ToDoList
//
//  Created by girlswhocode on 7/16/19.
//  Copyright © 2019 girlswhocode. All rights reserved.
//

import UIKit

class myTableViewCell: UITableViewCell {


    @IBOutlet weak var dashLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var taskLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
