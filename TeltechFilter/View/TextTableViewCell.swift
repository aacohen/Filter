//
//  TextTableViewCell.swift
//  TeltechFilter
//
//  Created by Ariela Cohen on 10/24/18.
//  Copyright © 2018 Ariela Cohen. All rights reserved.
//

import UIKit

class TextTableViewCell: UITableViewCell {

    var wordLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layoutElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layoutElements()
    }
    
    func layoutElements() {
        
        self.contentView.addSubview(wordLabel)
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        wordLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        wordLabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        wordLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        wordLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        wordLabel.backgroundColor = UIColor.init(hex: "9B9B9B").withAlphaComponent(0.50)
        wordLabel.textAlignment = .center
        wordLabel.textColor = UIColor.white
        
        self.contentView.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.clear
    }
    
}

