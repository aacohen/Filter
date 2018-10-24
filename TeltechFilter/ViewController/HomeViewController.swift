//
//  HomeViewController.swift
//  TeltechFilter
//
//  Created by Ariela Cohen on 10/21/18.
//  Copyright © 2018 Ariela Cohen. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {

    var blockListButton = UIButton()
    var imageView = UIImageView()
    var logoImageView = UIImageView()
    var filterTexts = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        CoreDataModel.shared.fetch()
        CoreDataModel.shared.fetchKeyWords()
        
    }
    
    
    func setupView() {
        
        self.view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        imageView.backgroundColor = UIColor.clear
        imageView.image = #imageLiteral(resourceName: "HomeViewImage")
        
        self.view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (self.view.frame.height/5.5)).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        logoImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
        logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor, multiplier: 0.45).isActive = true
        logoImageView.image = #imageLiteral(resourceName: "logo")

        
        self.view.addSubview(blockListButton)
        blockListButton.translatesAutoresizingMaskIntoConstraints = false
        blockListButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        blockListButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        blockListButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.6).isActive = true
        blockListButton.heightAnchor.constraint(equalTo: blockListButton.widthAnchor, multiplier: 0.25).isActive = true
        blockListButton.setTitle("BlockList", for: .normal)
        blockListButton.setTitleColor(UIColor.white, for: .normal)
        blockListButton.addTarget(self, action: #selector(blockListButtonPressed), for: .touchUpInside)
        blockListButton.backgroundColor = UIColor.init(hex: "9B9B9B").withAlphaComponent(0.29)
        blockListButton.layer.masksToBounds = true
        blockListButton.layer.cornerRadius = 30
        blockListButton.layer.borderWidth = 1
        blockListButton.layer.borderColor = UIColor.white.cgColor
        
        
        self.view.addSubview(filterTexts)
        filterTexts.translatesAutoresizingMaskIntoConstraints = false
        filterTexts.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        filterTexts.topAnchor.constraint(equalTo: blockListButton.bottomAnchor, constant: 20).isActive = true
        filterTexts.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.6).isActive = true
        filterTexts.heightAnchor.constraint(equalTo: filterTexts.widthAnchor, multiplier: 0.25).isActive = true
        filterTexts.setTitle("Filter Texts", for: .normal)
        filterTexts.setTitleColor(UIColor.white, for: .normal)
        filterTexts.addTarget(self, action: #selector(filterTextButtonPressed), for: .touchUpInside)
        filterTexts.backgroundColor = UIColor.init(hex: "9B9B9B").withAlphaComponent(0.29)
        filterTexts.layer.masksToBounds = true
        filterTexts.layer.cornerRadius = 30
        filterTexts.layer.borderWidth = 1
        filterTexts.layer.borderColor = UIColor.white.cgColor
        
    
    }
    
    @objc func blockListButtonPressed() {
        let destinationVc = BlockedListViewController()
        self.navigationController?.pushViewController(destinationVc, animated: true)
    }
    
    @objc func filterTextButtonPressed() {
        let destinationVc = TextTableViewController()
        self.navigationController?.pushViewController(destinationVc, animated: true)
    }
}

// Convert hex string to a UIColor
extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}
