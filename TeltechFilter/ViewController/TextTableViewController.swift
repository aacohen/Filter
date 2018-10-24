//
//  TextTableViewController.swift
//  TeltechFilter
//
//  Created by Ariela Cohen on 10/24/18.
//  Copyright © 2018 Ariela Cohen. All rights reserved.
//

import UIKit

class TextTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var textCellIdentifier = "textCell"
    
    
    var tableView: UITableView = UITableView()
    var headerView = UIView()
    var iconView = UIImageView()
    var titleView = UILabel()
    var addWordField = UITextField()
    var addButton = UIButton()
    var backgroundImageView = UIImageView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layouHeader()
        layoutTableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TextTableViewCell.self, forCellReuseIdentifier: textCellIdentifier)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    
    //MARK: Table View Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataModel.shared.wordList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath) as! TextTableViewCell
        
        let word = CoreDataModel.shared.wordList[indexPath.row].keyWord
        cell.wordLabel.text = word
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            CoreDataModel.shared.deleteKeyWord(indexPath: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } 
    }
    
    //    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        return "Blocked Calls"
    //    }
    
    // MARK: Setup Elements
    
    func layoutTableView() {
        
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.backgroundColor = UIColor.clear
        
    }
    
    func layouHeader() {
        
        self.view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        backgroundImageView.backgroundColor = UIColor.clear
        backgroundImageView.image = #imageLiteral(resourceName: "HomeViewImage")
        
        self.view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.4).isActive = true
        headerView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        headerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        headerView.backgroundColor = UIColor.clear
        
        headerView.addSubview(addWordField)
        addWordField.translatesAutoresizingMaskIntoConstraints = false
        addWordField.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 0.6).isActive = true
        addWordField.heightAnchor.constraint(equalTo: addWordField.widthAnchor, multiplier: 0.25).isActive = true
        addWordField.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        addWordField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        addWordField.backgroundColor = UIColor.init(hex: "9B9B9B").withAlphaComponent(0.29)
        addWordField.layer.cornerRadius = 30
        addWordField.layer.borderWidth = 1
        addWordField.layer.borderColor = UIColor.white.cgColor
        addWordField.attributedPlaceholder = NSAttributedString(string: "Key Word to Filter", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(0.70)])
        addWordField.textAlignment = .center
        
        headerView.addSubview(iconView)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        //        iconView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (self.view.frame.height/5.5)).isActive = true
        iconView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        iconView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4).isActive = true
        iconView.heightAnchor.constraint(equalTo: iconView.widthAnchor, multiplier: 0.45).isActive = true
        iconView.bottomAnchor.constraint(equalTo: addWordField.topAnchor, constant: -50).isActive = true
        iconView.image = #imageLiteral(resourceName: "logo")
        
        
        
        headerView.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.heightAnchor.constraint(equalTo: addWordField.heightAnchor).isActive = true
        addButton.widthAnchor.constraint(equalTo: addButton.heightAnchor).isActive = true
        addButton.leadingAnchor.constraint(equalTo: addWordField.trailingAnchor, constant: 10).isActive = true
        addButton.bottomAnchor.constraint(equalTo: addWordField.bottomAnchor).isActive = true
        addButton.setTitle("+", for: .normal)
        addButton.titleLabel?.adjustsFontSizeToFitWidth = true
        addButton.backgroundColor = UIColor.init(hex: "9B9B9B").withAlphaComponent(0.50)
        addButton.layer.cornerRadius = 30
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        
    }
    
    // MARK: Action Methods
    
    @objc func addButtonPressed() {
        
        //validate so can only press if 11 digits entered otherwise crashes
        
        
        guard let text = addWordField.text else { return }
            
            
            CoreDataModel.shared.createKeyWord(word: text)
            
            CoreDataModel.shared.saveContext()
            
            addWordField.text = ""
            
            tableView.reloadData()
       
    }
    
}
