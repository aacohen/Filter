//
//  BlockedListTableViewCell.swift
//  TeltechFilter
//
//  Created by Ariela Cohen on 10/21/18.
//  Copyright © 2018 Ariela Cohen. All rights reserved.
//

import UIKit

class BlockedListTableViewCell: UITableViewCell {

    var numberLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layoutElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layoutElements()
    }
    
    func layoutElements() {
        
        self.contentView.addSubview(numberLabel)
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        numberLabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        numberLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        numberLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        numberLabel.backgroundColor = UIColor.init(hex: "9B9B9B").withAlphaComponent(0.50)
        numberLabel.textAlignment = .center
        numberLabel.textColor = UIColor.white
        
        self.contentView.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.clear
    }
    
}
