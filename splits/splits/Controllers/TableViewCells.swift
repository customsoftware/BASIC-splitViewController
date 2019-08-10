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
            
            switch controllingEnum {
            case .exampleOne:
                textLabel?.text = "The First Choice"
                contentView.backgroundColor = UIColor.lightGray
                
            case .exampleTwo:
                textLabel?.text = "The Second Choice"
                contentView.backgroundColor = UIColor.darkGray
                textLabel?.textColor = .white
                
            case .exampleThree:
                textLabel?.text = "The Third Choice"
                textLabel?.textColor = .darkGray
            }
        }
    }
}
