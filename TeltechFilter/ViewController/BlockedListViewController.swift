//
//  BlockedListViewController.swift
//  TeltechFilter
//
//  Created by Ariela Cohen on 10/21/18.
//  Copyright © 2018 Ariela Cohen. All rights reserved.
//

import UIKit
import CallKit

class BlockedListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var callCellIdentifier = "callCell"
    
    
    var tableView: UITableView = UITableView()
    var headerView = UIView()
    var iconView = UIImageView()
    var titleView = UILabel()
    var addNumberField = UITextField()
    var addButton = UIButton()
    var backgroundImageView = UIImageView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layouHeader()
        layoutTableView()
        //        tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BlockedListTableViewCell.self, forCellReuseIdentifier: callCellIdentifier)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
     
    }
    

   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataModel.shared.blockedList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: callCellIdentifier, for: indexPath) as! BlockedListTableViewCell
    
        let number = CoreDataModel.shared.blockedList[indexPath.row]
        cell.numberLabel.text = String(number)
        return cell
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
        
        headerView.addSubview(addNumberField)
        addNumberField.translatesAutoresizingMaskIntoConstraints = false
        addNumberField.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 0.6).isActive = true
        addNumberField.heightAnchor.constraint(equalTo: addNumberField.widthAnchor, multiplier: 0.25).isActive = true
        addNumberField.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        addNumberField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        addNumberField.backgroundColor = UIColor.init(hex: "9B9B9B").withAlphaComponent(0.29)
        addNumberField.layer.cornerRadius = 30
        addNumberField.layer.borderWidth = 1
        addNumberField.layer.borderColor = UIColor.white.cgColor
        addNumberField.attributedPlaceholder = NSAttributedString(string: "Phone Number", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(0.70)])
        addNumberField.textAlignment = .center
        addNumberField.keyboardType = .numberPad
        
        headerView.addSubview(iconView)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        //        iconView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (self.view.frame.height/5.5)).isActive = true
        iconView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        iconView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4).isActive = true
        iconView.heightAnchor.constraint(equalTo: iconView.widthAnchor, multiplier: 0.45).isActive = true
        iconView.bottomAnchor.constraint(equalTo: addNumberField.topAnchor, constant: -50).isActive = true
        iconView.image = #imageLiteral(resourceName: "logo")

        
        
        headerView.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.heightAnchor.constraint(equalTo: addNumberField.heightAnchor).isActive = true
        addButton.widthAnchor.constraint(equalTo: addButton.heightAnchor).isActive = true
        addButton.leadingAnchor.constraint(equalTo: addNumberField.trailingAnchor, constant: 10).isActive = true
        addButton.bottomAnchor.constraint(equalTo: addNumberField.bottomAnchor).isActive = true
        addButton.setTitle("+", for: .normal)
        addButton.titleLabel?.adjustsFontSizeToFitWidth = true
        addButton.backgroundColor = UIColor.init(hex: "9B9B9B").withAlphaComponent(0.50)
        addButton.layer.cornerRadius = 30
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        
    }
    
    // MARK: Action Methods
    
    @objc func addButtonPressed() {
        
        //validate so can only press if 11 digits entered otherwise crashes
        
        
        guard let text = addNumberField.text else { return }
        
        if text.count == 11 {
        
        let number = (text as NSString).longLongValue
        
        CoreDataModel.shared.createPhoneCall(number: number)
        
        CoreDataModel.shared.saveContext()

        CoreDataModel.shared.blockedList.append(number)
        
        addNumberField.text = ""
        
        tableView.reloadData()
        } else {
            errorNotification()
        }
    }
    
    func errorNotification() {
        let alert = UIAlertController(title: "Error",
                                      message: "Please include country and area codes - 11 Digits",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
        
        }
}
