//
//  TableViewCells.swift
//  splits
//
//  Created by Kenneth Cluff on 8/10/19.
//  Copyright © 2019 Kenneth Cluff. All rights reserved.
//

import UIKit

class DemoCell: UITableViewCell {
    var controllingEnum: TestDetails? {
        didSet{
            guard let controllingEnum = controllingEnum else { return }
            
            selectionStyle = .none
            
            textLabel?.text = controllingEnum.detailText
            textLabel?.textColor = controllingEnum.textColor
            contentView.backgroundColor = controllingEnum.detailColor
        }
    }
}
