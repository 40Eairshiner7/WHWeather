//
//  sideMenu.swift
//  WHWeather
//
//  Created by airshiner on 10/12/16.
//  Copyright © 2016 airshiner. All rights reserved.
//

import UIKit

protocol showHomeView {
    func cityToHome()
    func locationToHome()
}

class sideMenuController: UIViewController {
    
    @IBOutlet weak var cityButton: UIButton!
    @IBOutlet weak var locationButton: UIButton!
    
    var delegate: showHomeView?
    
    @IBAction func toCityMdoel(_ sender: AnyObject) {
        delegate?.cityToHome()
    }
    
    @IBAction func toLocationModel(_ sender: AnyObject) {
        delegate?.locationToHome()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityButton.layer.borderWidth = 2
        cityButton.layer.borderColor = UIColor.blue.cgColor
        cityButton.layer.cornerRadius = 10
        cityButton.layer.masksToBounds = true
        
        locationButton.layer.borderWidth = 2
        locationButton.layer.borderColor = UIColor.blue.cgColor
        locationButton.layer.cornerRadius = 10
        locationButton.layer.masksToBounds = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
