//
//  sideMenu.swift
//  WHWeather
//
//  Created by airshiner on 10/12/16.
//  Copyright © 2016 airshiner. All rights reserved.
//

import UIKit

class sideMenuController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var sideMenuImage: UIImageView!
    @IBOutlet weak var sideMenuLabel: UILabel!
    @IBOutlet weak var sideMenuTable: UITableView!
    
    override func viewDidLoad() {
        sideMenuTable.delegate = self
        sideMenuTable.dataSource = self
        sideMenuTable.tableFooterView = UIView()
        sideMenuImage.image = UIImage(named: "Icon")
        sideMenuLabel.text = "Fuzhouuuuuuuuuuuuuuuuuuuuu"
        sideMenuLabel.font = UIFont.systemFont(ofSize: 30)
        sideMenuTable.separatorStyle = .none
        super.viewDidLoad()
    }
        
    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "sideMenuCell", for: indexPath)
        cell.textLabel!.text = "unknownnnnnnnnnnnnnnnn"
        cell.tintColor = UIColor.black
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.font = UIFont.systemFont(ofSize: 30)
        sideMenuLabel.backgroundColor = UIColor.black
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
